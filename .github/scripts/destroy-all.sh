#!/bin/bash
set -e

echo "Destroying Terraform-managed infrastructure..."
bash .github/scripts/destroy-tasks-bucket.sh

echo "Terraform destroy done."
bash .github/scripts/destroy-terraform-backend.sh

echo "✅ All destruction complete!"
