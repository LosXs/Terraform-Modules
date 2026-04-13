# Example: complete-landing-zone (started)

This v0.1 example provisions a **resource group** and a **Log Analytics workspace** using validated tags and CAF-style names.

Later milestones will add networking, Key Vault, App Service, diagnostics to compute, and other components per the library build order.

## Prerequisites

Same as `examples/single-resource`: Terraform `>= 1.9.0`, Azure credentials, `subscription_id`.

## Usage

```bash
cd examples/complete-landing-zone
terraform init -backend=false
terraform apply -var="subscription_id=YOUR_SUBSCRIPTION_ID"
```

Diagnostic settings from application or platform resources to Log Analytics will be added when the corresponding modules (web app, databases, etc.) are published.
