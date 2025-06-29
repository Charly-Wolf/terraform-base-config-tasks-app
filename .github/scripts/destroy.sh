#!/bin/bash
set -e

echo "⚠️ Destroying all infra without confirmation..."
terraform destroy -auto-approve

echo "💣 Infrastructure destroyed."
