#!/bin/bash
set -e # Exit on any error

echo "Initializing Terraform..."
terraform fmt -check -recursive || echo "⚠️ Terraform format check failed, continuing anyway..."

echo "Running 'terraform init' with backend config..."
terraform init -upgrade

echo "✅ Init complete!"