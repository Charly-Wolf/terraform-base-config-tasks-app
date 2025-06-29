#!/bin/bash
set -e # Exit on any error

PLAN_FILE="plan.tfplan"

if [[ ! -f "$PLAN_FILE" ]]; then
  echo "❌ Plan file $PLAN_FILE not found. Run 'make plan' first."
  exit 1
fi

echo "Checking S3 bucket for public access configuration..."
aws s3api put-public-access-block --bucket cardp-tasks-frontend-bucket --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false


echo "Applying Terraform plan..."
terraform apply "$PLAN_FILE"

echo "✅ Apply complete!"