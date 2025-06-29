#!/bin/bash
set -e # Exit on any error

echo "Initializing Terraform..."
terraform fmt -check

echo "Running 'terraform init' with backend config..."
terraform init -upgrade

echo "✅ Init complete!"