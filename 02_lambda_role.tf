#---------------------------------LAMBDA ROLE---------------------------------
data "aws_iam_policy_document" "lambda_role" {

    statement {
       
        effect = "Allow"

        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers = ["lambda.amazonaws.com"]
        }
    }
}



resource "aws_iam_role" "iam_for_lambda" {
    name = "iam_for_lambda"
    assume_role_policy = data.aws_iam_policy_document.lambda_role.json
}

#---------------------------------LAMBDA POLICY---------------------------------
data "aws_iam_policy_document" "lambda_policy" {
    statement {
        sid = "1"
        actions = [
             "ec2:StartInstances",
             "ec2:StopInstances",
             "ec2:DescribeInstances"
        ]

        resources = ["*"]
        # effect = "Allow"
    }
}

resource "aws_iam_policy" "lambda_policy" {
    name = "stopStart-instances"
    description = "Policy pour permettre à la lambda de démarrer et d'arrêter les instances EC2"
    path = "/"
    policy = data.aws_iam_policy_document.lambda_policy.json
}

# Attacher la police a la role IAM
resource "aws_iam_role_policy_attachment" "custom_policy" {

    role = aws_iam_role.iam_for_lambda.name
    policy_arn = aws_iam_policy.lambda_policy.arn
}   