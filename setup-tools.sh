#!/usr/bin/env bash
set -e

echo "🐳 Installing Docker..."
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt-get update
  sudo apt-get install -y docker.io docker-compose-plugin
  sudo systemctl enable --now docker
  sudo usermod -aG docker $USER
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install --cask docker
else
  echo "⚠️ Please install Docker manually for Windows."
fi

echo "📦 Installing syft (SBOM tool)..."
curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin

echo "🔎 Installing trivy (vulnerability scanner)..."
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh
sudo mv trivy /usr/local/bin/

echo "🔐 Installing cosign (sign/verify tool)..."
COSIGN_VERSION=$(curl -s https://api.github.com/repos/sigstore/cosign/releases/latest | grep tag_name | cut -d '"' -f 4)
curl -L https://github.com/sigstore/cosign/releases/download/${COSIGN_VERSION}/cosign-$(uname -s | tr '[:upper:]' '[:lower:]')-amd64 -o cosign
chmod +x cosign && sudo mv cosign /usr/local/bin/

echo "☸️ Installing kind (local Kubernetes)..."
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-$(uname)-amd64
chmod +x ./kind && sudo mv ./kind /usr/local/bin/

echo "⚡ Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/$(uname | tr '[:upper:]' '[:lower:]')/amd64/kubectl"
chmod +x kubectl && sudo mv kubectl /usr/local/bin/

echo "🤖 Installing act (run GitHub Actions locally)..."
curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

echo "✅ All tools installed. Restart your shell to update PATH."
