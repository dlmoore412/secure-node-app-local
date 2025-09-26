# 🚀 Secure Node App

[![Build & Secure](https://github.com/<owner>/<repo>/actions/workflows/build-sign.yml/badge.svg)](https://github.com/<owner>/<repo>/actions/workflows/build-sign.yml)
[![GHCR Image](https://ghcr-badge.egpl.dev/<owner>/<repo>/secure-node-app/latest_tag.svg)](https://github.com/<owner>/<repo>/pkgs/container/secure-node-app)
[![Security Scan](https://img.shields.io/badge/scan-passed-brightgreen?logo=trivy)](https://github.com/aquasecurity/trivy)

This repository demonstrates how to build, scan, sign, and secure a Node.js container image using:

- **GitHub Actions**
- **Cosign** (keyless, OIDC)
- **Anchore** (SBOM generation)
- **Trivy** (vulnerability scanning)
- *(Optional)* **SLSA provenance**

---

## 🔐 What this pipeline ensures
Every container image built from this repo is:

✅ Built and pushed to **GitHub Container Registry (GHCR)**  
📦 Accompanied by a **Software Bill of Materials (SBOM)**  
🔍 Scanned for vulnerabilities using **Trivy**  
🔏 Signed using **Cosign** (keyless, OIDC-based)  
📜 Optionally recorded with **SLSA Provenance**  

---

## 🛠️ Workflow Overview

```mermaid
flowchart TD
  A[Checkout Code] --> B[Build Docker Image]
  B --> C[Push to GHCR]
  C --> D[Generate SBOM with Anchore]
  C --> E[Scan with Trivy]
  C --> F[Sign with Cosign]
  F --> G{SLSA Provenance?}
.
├── .github/
│   └── workflows/
│       └── build-sign.yml   # CI/CD workflow
├── Dockerfile               # Node.js app container definition
├── package.json             # Node.js dependencies
└── README.md                # This documentation
▶️ Running the Workflow

Push to the main branch or open a Pull Request.

GitHub Actions will automatically:

Build and push your image to ghcr.io/<owner>/<repo>/secure-node-app:<sha>

Generate an SBOM (sbom.json)

Run a Trivy vulnerability scan

Sign the container image with Cosign

(Optional) Generate *SLSA provenance

🔎 Verification

Verify a signed image locally with Cosign:

cosign verify ghcr.io/<owner>/<repo>/secure-node-app@sha256:<digest>


📖 References

Cosign

Anchore SBOM Action

Trivy

SLSA Framework
---


