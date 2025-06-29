#!/bin/bash
set -e

echo "Destroying Terraform-managed infrastructure..."
terraform destroy -auto-approve

echo "Terraform destroy done."
bash .github/scripts/destroy-backend.sh

echo "✅ All destruction complete!"
