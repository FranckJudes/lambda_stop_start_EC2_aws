data "archive_file" "stop" {
    type = "zip"
    source_dir = "${path.module}/code"
    output_path = "${path.module}/code.zip"
}

resource "aws_lambda_function" "stop" {
    function_name = "stop-instance"
    role = aws_iam_role.role.arn # Creation de role IAM pour la lambda
    runtime = "python3.10.18" # Version de Python sur lequel le code python va tourner
    handler = "main.lambda_handler" # Nom du fichier python et de la fonction lambda
    timeout = 300 # Timeout de la lambda
    memory_size = 128 # Mémoire de la lambda
    filename = "${data.archive_file.stop.output_path}" # Fichier zip contenant le code python
    source_code_hash = filebase64sha256("${data.archive_file.stop.output_path}") # Hash du code python


    environment {
        variables = {
            ACTION = "stop"
        }
    }
}


#---------------------------------START LAMBDA---------------------------------

resource "aws_lambda_function" "start" {
    function_name = "start-instance"
    role = aws_iam_role.role.arn # Creation de role IAM pour la lambda
    runtime = "python3.10.18" # Version de Python sur lequel le code python va tourner
    handler = "main.lambda_handler" # Nom du fichier python et de la fonction lambda
    timeout = 300 # Timeout de la lambda
    memory_size = 128 # Mémoire de la lambda
    filename = "${data.archive_file.stop.output_path}" # Fichier zip contenant le code python
    source_code_hash = filebase64sha256("${data.archive_file.stop.output_path}") # Hash du code python


    environment {
        variables = {
            ACTION = "start"
        }
    }
}