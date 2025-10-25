from nt import environ
import boto3
import json

REGION = "eu-west-1"
ACTION = environ["ACTION"]

def lambda_handler(event, context):
    if ACTION.lower() == "stop":
        stop_instance()
    elif ACTION.lower() == "start":
        start_instance()
    else:
        print("Action non valide") 



def stop_instance():
    ec2 = boto3.client("ec2", region_name=REGION)

    filters = [
        {
            "Name": "tag:AutoStop",
            "Values": ["true"]
        }
    ]
    instances = ec2.describe_instances(Filters=filters)
    instance_ids = [instance["InstanceId"] for instance in instances["Instances"]]
    if len(instance_ids):
        ec2.stop_instances(InstanceIds=instance_ids)
        print(f"Arrêt des instances: {instance_ids}")
    else:
        print("Aucune instance trouvée avec le tag AutoStop")

def start_instance():
    ec2 = boto3.client("ec2", region_name=REGION)
    filters = [
        {
            "Name": "tag:AutoStart",
            "Values": ["true"]
        }
    ]
    instances = ec2.describe_instances(Filters=filters)
    instance_ids = [instance["InstanceId"] for instance in instances["Instances"]]
    if len(instance_ids):
        ec2.start_instances(InstanceIds=instance_ids)
        print(f"Démarrage des instances: {instance_ids}")
    else:
        print("Aucune instance trouvée avec le tag AutoStart")  