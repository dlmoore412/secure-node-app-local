# 🚀 Secure Node App

This repository demonstrates how to build, scan, sign, and secure a Node.js container image using **GitHub Actions**, **Cosign**, **Anchore**, **Trivy**, and **SLSA provenance**.

The CI/CD pipeline ensures that every container image built from this repository is:
- ✅ Built and pushed to GitHub Container Registry (GHCR)  
- 📦 Accompanied by an **SBOM** (Software Bill of Materials)  
- 🔍 Scanned for vulnerabilities using **Trivy**  
- 🔏 Signed using **Cosign** (keyless, OIDC-based)  
- 📜 Optionally secured with **SLSA Provenance**  

---

## 🛠️ Workflow Overview

```mermaid
flowchart TD
    A[Checkout Code] --> B[Build Docker Image]
    B --> C[Push Image to GHCR]
    C --> D[Generate SBOM with Anchore]
    D --> E[Scan with Trivy]
    E --> F[Sign Image with Cosign (keyless)]
    F --> G{Optional: SLSA Provenance}
