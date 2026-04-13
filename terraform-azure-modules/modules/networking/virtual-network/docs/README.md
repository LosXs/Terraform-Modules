# Virtual network

> Deploys `azurerm_virtual_network` with optional custom DNS servers and optional diagnostics.

## Overview

Defines address space for a landing zone or spoke. Pair with the `subnet` module for child subnets. Tags use `lifecycle { ignore_changes = [tags] }` for inherit-tags policy.

## Architecture diagram

```mermaid
graph LR
  RG[Resource group]
  VNET[Virtual network]
  RG --> VNET
```

## Usage

```hcl
module "vnet" {
  source = "../../modules/networking/virtual-network"

  resource_group_name = module.rg.name
  location            = "uksouth"
  tags                = module.tags.tags
  name                = module.naming.virtual_network
  address_space       = ["10.60.0.0/16"]
}
```

## Input variables

| Name | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| resource_group_name | string | — | yes | RG name |
| location | string | uksouth | no | Must be `uksouth` |
| tags | map(string) | — | yes | `_shared/tags` output |
| name | string | — | yes | VNet name |
| address_space | list(string) | — | yes | CIDR list |
| dns_servers | list(string) | null | no | Custom DNS IPs |
| diagnostics_settings | object | null | no | Forward to LAW |

## Outputs

| Name | Description |
|------|-------------|
| id | VNet ID |
| name | VNet name |
| virtual_network | Resource object |

## Policy compliance

- **UK South / tags:** Enforced via `location` and `var.tags`; ignore tag drift on resource.

## Resource naming

Typically `vnet-{workload}-{env}-{instance}` from `_shared/naming`.

## Versioning

Monorepo semver tags.

## Known limitations

- Peering and DDoS plans are out of scope for this module; add separately if needed.
