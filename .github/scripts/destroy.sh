#!/bin/bash
set -e

read -p "⚠️ Are you sure you want to destroy all infra? (yes/no): " CONFIRM
if [[ "$CONFIRM" != "yes" ]]; then
  echo "Aborted."
  exit 0
fi

terraform destroy -auto-approve

echo "💣 Infrastructure destroyed."
