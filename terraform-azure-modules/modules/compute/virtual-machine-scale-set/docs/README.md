# Linux virtual machine scale set

> Deploys `azurerm_linux_virtual_machine_scale_set` with a single subnet, SSH key auth, and optional diagnostics.

## Overview

Set `instances` and `sku` for capacity and size. Uses `source_image` defaults aligned to Ubuntu 22.04 unless overridden.

## Architecture diagram

```mermaid
flowchart LR
  T[tags]
  VMSS[azurerm_linux_virtual_machine_scale_set]
  D[diagnostic_setting optional]
  T --> VMSS
  VMSS --> D
```

## Usage

```hcl
module "vmss" {
  source = "../../modules/compute/virtual-machine-scale-set"

  resource_group_name  = module.rg.name
  location             = "uksouth"
  tags                 = module.tags.tags
  name                 = "web"
  subnet_id            = module.snet.id
  admin_username       = "azureuser"
  admin_ssh_public_key = file("~/.ssh/id_rsa.pub")
}
```

## Input variables

| Name | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| resource_group_name | string | — | yes | Resource group name |
| location | string | uksouth | no | Must be `uksouth` |
| tags | map(string) | — | yes | `_shared/tags` output |
| name | string | — | yes | VMSS name |
| sku | string | Standard_B2s | no | Instance size |
| instances | number | 2 | no | Instance count |
| admin_username | string | — | yes | Linux admin |
| admin_ssh_public_key | string | — | yes | SSH public key |
| subnet_id | string | — | yes | Subnet ID |
| source_image | object | Ubuntu 22.04 | no | Image reference |
| diagnostics_settings | object | null | no | Diagnostics to LAW |

## Outputs

| Name | Type | Description |
|------|------|-------------|
| id | string | VMSS ID |
| name | string | VMSS name |
| virtual_machine_scale_set | object | Resource object |

## Policy compliance

- **Tags / location:** `uksouth` validation; `lifecycle { ignore_changes = [tags] }`.

## Versioning

Monorepo semver tags.

## Known limitations

- Autoscale rules, rolling upgrades, and custom images are not modeled here.
