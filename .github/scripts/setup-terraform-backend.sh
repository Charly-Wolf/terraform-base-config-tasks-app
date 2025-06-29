#!/bin/bash
set -e # Exit on any error

# Config
REGION="us-east-1"
BUCKET_NAME="cardp-terraform-state-bucket"

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

echo "✅ Backend setup complete!"
