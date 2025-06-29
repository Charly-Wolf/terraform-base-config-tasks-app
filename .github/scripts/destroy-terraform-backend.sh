#!/bin/bash
set -e

REGION="us-east-1"
BUCKET_NAME="cardp-terraform-state-bucket"
DYNAMO_TABLE_NAME="terraform-locks"

echo "Deleting all objects from S3 bucket: $BUCKET_NAME..."
aws s3 rm s3://$BUCKET_NAME --recursive --region $REGION

echo "Deleting S3 bucket: $BUCKET_NAME..."
aws s3api delete-bucket --bucket $BUCKET_NAME --region $REGION

echo "Deleting DynamoDB table: $DYNAMO_TABLE_NAME..."
aws dynamodb delete-table --table-name $DYNAMO_TABLE_NAME --region $REGION

echo "✅ Backend destroy complete!"
