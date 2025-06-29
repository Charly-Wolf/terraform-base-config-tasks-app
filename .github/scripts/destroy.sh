#!/bin/bash
set -e

REGION="us-east-1"

function delete_bucket_versions_and_markers() {
  local BUCKET_NAME="$1"
  echo "Deleting all object versions and delete markers from bucket: $BUCKET_NAME..."

  # Delete all object versions
  versions=$(aws s3api list-object-versions --bucket "$BUCKET_NAME" --region "$REGION" --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')
  echo "$versions" | jq -c '.Objects[]?' | while read -r obj; do
    key=$(echo "$obj" | jq -r '.Key')
    versionId=$(echo "$obj" | jq -r '.VersionId')
    aws s3api delete-object --bucket "$BUCKET_NAME" --key "$key" --version-id "$versionId" --region "$REGION"
  done

  # Delete all delete markers
  markers=$(aws s3api list-object-versions --bucket "$BUCKET_NAME" --region "$REGION" --query='{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}')
  echo "$markers" | jq -c '.Objects[]?' | while read -r obj; do
    key=$(echo "$obj" | jq -r '.Key')
    versionId=$(echo "$obj" | jq -r '.VersionId')
    aws s3api delete-object --bucket "$BUCKET_NAME" --key "$key" --version-id "$versionId" --region "$REGION"
  done
}

function destroy_tasks_bucket() {
  local BUCKET_NAME="cardp-tasks-frontend-bucket"
  echo "🧹 Destroying tasks bucket: $BUCKET_NAME"
  delete_bucket_versions_and_markers "$BUCKET_NAME"
  echo "Deleting bucket $BUCKET_NAME..."
  aws s3api delete-bucket --bucket "$BUCKET_NAME" --region "$REGION"
  echo "Tasks bucket destroyed."
}

function destroy_terraform_backend() {
  local BUCKET_NAME="cardp-terraform-state-bucket"
  echo "🧹 Destroying Terraform backend bucket"

  delete_bucket_versions_and_markers "$BUCKET_NAME"
  echo "Deleting bucket $BUCKET_NAME..."
  aws s3api delete-bucket --bucket "$BUCKET_NAME" --region "$REGION"

  echo "Terraform backend destroyed."
}

function destroy_all() {
  echo "Destroying Terraform-managed infrastructure..."

  destroy_tasks_bucket
  destroy_terraform_backend

  terraform destroy -auto-approve

  echo "✅ All destruction complete!"
}

case "$1" in
  all)
    destroy_all
    ;;
  tasks)
    destroy_tasks_bucket
    ;;
  tf-backend)
    destroy_terraform_backend
    ;;
  *)
    echo "Usage: $0 {all|tasks|tf-backend}"
    exit 1
    ;;
esac
