#!/bin/bash
set -e

REGION="us-east-1"
BUCKET_NAME="cardp-terraform-state-bucket"
DYNAMO_TABLE_NAME="terraform-locks"

echo "Deleting all object versions and delete markers from S3 bucket: $BUCKET_NAME..."

# Delete all object versions
versions=$(aws s3api list-object-versions --bucket $BUCKET_NAME --region $REGION --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')
echo $versions | jq -c '.Objects[]?' | while read obj; do
  key=$(echo $obj | jq -r '.Key')
  versionId=$(echo $obj | jq -r '.VersionId')
  aws s3api delete-object --bucket $BUCKET_NAME --key "$key" --version-id "$versionId" --region $REGION
done

# Delete all delete markers
markers=$(aws s3api list-object-versions --bucket $BUCKET_NAME --region $REGION --query='{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}')
echo $markers | jq -c '.Objects[]?' | while read obj; do
  key=$(echo $obj | jq -r '.Key')
  versionId=$(echo $obj | jq -r '.VersionId')
  aws s3api delete-object --bucket $BUCKET_NAME --key "$key" --version-id "$versionId" --region $REGION
done

echo "Deleting S3 bucket: $BUCKET_NAME..."
aws s3api delete-bucket --bucket $BUCKET_NAME --region $REGION

echo "Deleting DynamoDB table: $DYNAMO_TABLE_NAME..."
aws dynamodb delete-table --table-name $DYNAMO_TABLE_NAME --region $REGION

echo "✅ Backend destroy complete!"
