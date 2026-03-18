import json
import boto3
import os

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['TABLE_NAME'])

def lambda_handler(event, context):
    try:
        body = json.loads(event['body'])
        item_id = body.get("id")

        table.delete_item(
            Key={"id": item_id}
        )

        return {
            "statusCode": 200,
            "body": json.dumps({"deleted_id": item_id})
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }