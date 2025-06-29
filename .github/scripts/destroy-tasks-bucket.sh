#!/bin/bash
set -e

BUCKET_NAME="cardp-tasks-frontend-bucket"

echo "🧹 Deleting all objects and versions in bucket $BUCKET_NAME..."

# Delete all object versions
versions=$(aws s3api list-object-versions --bucket $BUCKET_NAME --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')
echo $versions | jq -c '.Objects[]?' | while read obj; do
  key=$(echo $obj | jq -r '.Key')
  versionId=$(echo $obj | jq -r '.VersionId')
  aws s3api delete-object --bucket $BUCKET_NAME --key "$key" --version-id "$versionId"
done

# Delete all delete markers
markers=$(aws s3api list-object-versions --bucket $BUCKET_NAME --query='{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}')
echo $markers | jq -c '.Objects[]?' | while read obj; do
  key=$(echo $obj | jq -r '.Key')
  versionId=$(echo $obj | jq -r '.VersionId')
  aws s3api delete-object --bucket $BUCKET_NAME --key "$key" --version-id "$versionId"
done

echo "⚠️ Destroying all infra without confirmation..."
terraform destroy -auto-approve

echo "💣 Infrastructure destroyed."
