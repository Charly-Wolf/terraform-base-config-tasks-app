#!/bin/bash
set -e # Exit on any error

# Config
REGION="us-east-1"
BUCKET_NAME="cardp-terraform-state-bucket"
DYNAMO_TABLE_NAME="terraform-locks"

# Create Bucket
echo "Creating S3 bucket: $BUCKET_NAME (if not exists)..."
if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
  echo "Bucket already exists. Skipping creation."
else 
  aws s3api create-bucket \
    --bucket "$BUCKET_NAME" \
    --region "$REGION"
fi

# Enable Versioning
echo "Enabling versioning on bucket..."
aws s3api put-bucket-versioning \
  --bucket "$BUCKET_NAME" \
  --versioning-configuration Status=Enabled

# Create DynamoDB table for state locking
echo "Creating DynamoDB table: $DYNAMO_TABLE_NAME (if not exists)..."
if aws dynamodb describe-table --table-name "$DYNAMO_TABLE_NAME" --region "$REGION" >/dev/null 2>&1; then
  echo "DynamoDB table already exists. Skipping creation."
else
  aws dynamodb create-table \
    --table-name "$DYNAMO_TABLE_NAME" \
    --attribute-definitions AttributeName=LockId,AttributeType=S \
    --key-schema AttributeName=LockId,KeyType=HASH \
    --region "$REGION"
fi

echo "✅ Backend setup complete!"
