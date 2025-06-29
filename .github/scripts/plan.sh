#!/bin/bash
set -e # Exit on any error

echo "Running Terraform plan..."
terraform validate

terraform plan \
  -out="plan.tfplan"

echo "✅ Plan saved to plan.tfplan"