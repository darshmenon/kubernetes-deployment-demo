#!/bin/bash
set -e

# Rollback script
echo "Rolling back myapp..."

helm rollback myapp 0

echo "Rollback successful!"
