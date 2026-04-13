# Example: single-resource

Minimal stack: `_shared/tags` → `_shared/naming` → `governance/resource-group`.

## Prerequisites

- Terraform `>= 1.9.0`
- Azure credentials (`az login`) or service principal environment variables
- `subscription_id` for the target subscription (azurerm provider v4 requires it)

## Usage

```bash
cd examples/single-resource
terraform init -backend=false
terraform plan -var="subscription_id=YOUR_SUBSCRIPTION_ID"
terraform apply -var="subscription_id=YOUR_SUBSCRIPTION_ID"
```

Destroy when finished:

```bash
terraform destroy -var="subscription_id=YOUR_SUBSCRIPTION_ID"
```

This example creates a **resource group** in **uksouth** with validated organisational tags. Review cost and naming in your subscription before applying.
