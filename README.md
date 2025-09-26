# Secure Node App

[![Build & Sign](https://github.com/dlmoore412/secure-node-app-local/actions/workflows/build-sign.yml/badge.svg)](https://github.com/dlmoore412/secure-node-app-local/actions/workflows/build-sign.yml)

A sample Node.js application demonstrating **secure build, signing, SBOM generation, and vulnerability scanning** using GitHub Actions, Cosign, Anchore, and Trivy.

---

## Table of Contents

- [Overview](#overview)  
- [Workflow](#workflow)  
- [Getting Started](#getting-started)  
- [SBOM & Vulnerability Scanning](#sbom--vulnerability-scanning)  
- [Container Signing with Cosign](#container-signing-with-cosign)  
- [License](#license)

---

## Overview

This project demonstrates a **modern secure software supply chain**:

1. Build the Docker image of your Node.js app.  
2. Generate an SBOM (Software Bill of Materials) to track all dependencies.  
3. Scan the image for vulnerabilities using Trivy.  
4. Sign the image with Cosign (keyless, via GitHub OIDC).  
5. Optionally, generate SLSA provenance for full supply chain transparency.

---

## Workflow

The GitHub Actions workflow `build-sign.yml` orchestrates the entire process:

mermaid
flowchart TD
    A[GitHub Push / PR] --> B[Checkout Code]
    B --> C[Build Docker Image]
    C --> D[Push to GHCR]
    D --> E[Generate SBOM with Anchore]
    D --> F[Scan Image with Trivy]
    D --> G[Sign Image with Cosign (keyless)]
    G --> H[Optional: SLSA Provenance Generation]
Legend:

GHCR = GitHub Container Registry

SBOM = Software Bill of Materials

## Getting Started

Prerequisites

Docker

GitHub CLI
 (optional, for local testing)

macOS, Linux, or Windows environment

###Local Test
# Clone the repo
git clone https://github.com/dlmoore412/secure-node-app-local.git
cd secure-node-app-local

# Build Docker image locally
docker build -t secure-node-app:local .

# Run the container
docker run -p 3000:3000 secure-node-app:local

###SBOM & Vulnerability Scanning
SBOM (Software Bill of Materials) tracks all dependencies and their versions:
# Generate SBOM (via GitHub Action)
# Outputs: sbom.json

Trivy scans the image for vulnerabilities:
# Scan locally
trivy image secure-node-app:local

###Container Signing with Cosign
# Sign image
cosign sign --yes ghcr.io/dlmoore412/secure-node-app-local/secure-node-app:<SHA>

# Verify signature
cosign verify --certificate-oidc-issuer "https://token.actions.githubusercontent.com" ghcr.io/dlmoore412/secure-node-app-local/secure-node-app:<SHA>

flowchart TD
    A[Docker Image] --> B[Cosign Keyless Sign]
    B --> C[GitHub OIDC Verification]
    C --> D[Signature Stored in GHCR & TLog]

flowchart TD
    A[Build Docker Image] --> B[SLSA Generator]
    B --> C[slsa-provenance.json]
Notes:

In GitHub Actions, id-token: write permission is required for keyless signing.

Use SHA digests for production builds to avoid tag ambiguity.
