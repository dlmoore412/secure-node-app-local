#!/usr/bin/env bash
set -euo pipefail

IMAGE="secure-node-app:local"
KIND_CLUSTER="secure-test"

echo "🚀 Starting local secure pipeline test..."

# Build Docker image
docker build -t $IMAGE .

# Run container
docker run -d --rm -p 3000:3000 --name secure-node-app-test $IMAGE
sleep 2
curl -s http://localhost:3000 || echo "⚠️ Could not reach app"
docker stop secure-node-app-test

# Generate SBOM
syft packages docker:$IMAGE -o spdx-json > sbom.json

# Scan image
trivy image --exit-code 0 --format table $IMAGE

# Cosign signing/verification
if [[ ! -f cosign.key || ! -f cosign.pub ]]; then
  cosign generate-key-pair
fi
cosign sign --yes --key cosign.key $IMAGE
cosign verify --key cosign.pub $IMAGE

# GitHub Actions locally
act push -j build-and-secure

# Kubernetes + Kyverno
kind create cluster --name $KIND_CLUSTER || true
kind load docker-image $IMAGE --name $KIND_CLUSTER
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl create -f https://raw.githubusercontent.com/kyverno/kyverno/main/config/release/install.yaml
kubectl wait --for=condition=available --timeout=120s deployment/kyverno -n kyverno
kubectl apply -f k8s/verify-image-policy.yaml

# Test Kyverno enforcement
set +e
kubectl run unsigned-test --image=nginx:1.25
if [ $? -eq 0 ]; then
  echo "❌ Policy did NOT block unsigned image."
else
  echo "✅ Policy correctly blocked unsigned image."
fi
set -e

echo "🎉 Local pipeline test complete!"
