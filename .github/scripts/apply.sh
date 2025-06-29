#!/bin/bash
set -e # Exit on any error

PLAN_FILE="plan.tfplan"

if [[ ! -f "$PLAN_FILE" ]]; then
  echo "❌ Plan file $PLAN_FILE not found. Run 'make plan' first."
  exit 1
fi

echo "Applying Terraform plan..."
terraform apply "$PLAN_FILE"

echo "✅ Apply complete!"