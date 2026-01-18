#!/bin/bash
set -e

# Deployment script
echo "Deploying myapp..."

helm upgrade --install myapp ./helm/myapp \
  -f helm/myapp/values-prod.yaml \
  --wait --timeout 5m

echo "Deployment successful!"
