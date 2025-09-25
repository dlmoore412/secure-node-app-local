#!/bin/bash
set -e

echo "Cleaning up old manual installs..."
rm -rf ./bin trivy syft cosign 2>/dev/null || true
rm -rf /usr/local/bin/trivy /usr/local/bin/syft /usr/local/bin/cosign 2>/dev/null || true

echo "Updating Homebrew..."
brew update

echo "Installing required tools via Homebrew..."

# Docker CLI (if not already installed)
brew install --cask docker || true

# Syft for SBOM
brew install syft

# Trivy for vulnerability scanning
brew install trivy

# Cosign for signing images
brew install cosign

# kubectl for Kubernetes
brew install kubectl

# kind for local Kubernetes cluster (optional)
brew install kind

# Terraform for EKS deployment
brew install terraform

# act for local GitHub Actions testing
brew install act

echo "All tools installed!"
echo "Verify installation by running:"
echo "  syft --version"
echo "  trivy --version"
echo "  cosign version"
echo "  kubectl version --client"
echo "  terraform version"
echo "  act --version"
