# 🚀 Secure Node App

This repository demonstrates how to **build, scan, sign, and secure** a Node.js container image using:

- GitHub Actions
- Cosign (keyless, OIDC)
- Anchore (SBOM)
- Trivy (vulnerability scanning)
- (Optional) SLSA provenance

The CI/CD pipeline ensures each container image is:
- ✅ Built and pushed to GitHub Container Registry (GHCR)  
- 📦 Accompanied by an SBOM (Software Bill of Materials)  
- 🔍 Scanned for vulnerabilities using Trivy  
- 🔏 Signed using Cosign (keyless, OIDC-based)  
- 📜 Optionally recorded with SLSA provenance

---

## Workflow diagram

```mermaid
flowchart TD
  A[Checkout] --> B[Build Image]
  B --> C[Push to GHCR]
  C --> D[Generate SBOM]
  C --> E[Trivy Scan]
  C --> F[Cosign Sign]
  F --> G[SLSA Provenance (optional)]
