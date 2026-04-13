# Example: complete-landing-zone (started)

This example deploys a minimal **landing zone** in **UK South**:

- Validated tags and CAF-style names
- Resource group
- Log Analytics workspace
- Virtual network and subnet
- Network security group (no inline rules in this sample) and subnet–NSG association
- Diagnostic settings on VNet, subnet, and NSG to the Log Analytics workspace (where supported)

## Prerequisites

- Terraform `>= 1.9.0`
- Azure credentials and `subscription_id` for the azurerm v4 provider

## Usage

```powershell
cd examples/complete-landing-zone
terraform init -backend=false
$env:TF_VAR_subscription_id = "<your-subscription-id>"
terraform plan
terraform apply
```

Uncomment `backend.tf` when using remote state.

## Next steps

Future milestones can add Key Vault, private endpoints, App Service or AKS, and database modules per the library build order.
