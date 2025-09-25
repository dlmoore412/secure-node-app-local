#!/bin/bash
set -e

IMAGE="secure-node-app:local"

# Build the Docker image locally
docker build -t $IMAGE .

# Generate SBOM locally
syft $IMAGE -o spdx-json > sbom.json

# Scan for vulnerabilities
trivy image --exit-code 0 --format table $IMAGE

# Sign the image locally
cosign sign --key cosign.key --local-image $IMAGE
cosign verify --key cosign.pub --local-image $IMAGE

echo "✅ Local build, scan, and sign completed successfully"
