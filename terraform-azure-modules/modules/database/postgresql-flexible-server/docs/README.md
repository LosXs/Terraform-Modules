# PostgreSQL flexible server

> Deploys `azurerm_postgresql_flexible_server` with optional diagnostics.

## Overview

Use a unique `name`, set `postgresql_version`, `sku_name`, and storage via `storage_mb`. Administrator credentials are sensitive inputs. Tune `backup_retention_days` for your RPO requirements.

## Architecture diagram

```mermaid
flowchart LR
  T[tags]
  PG[azurerm_postgresql_flexible_server]
  D[diagnostic_setting optional]
  T --> PG
  PG --> D
```

## Usage

```hcl
module "pg" {
  source = "../../modules/database/postgresql-flexible-server"

  resource_group_name   = module.rg.name
  location              = "uksouth"
  tags                  = module.tags.tags
  name                  = "app-pg"
  administrator_login   = "pgadmin"
  administrator_password = var.pg_password
  sku_name              = "B_Standard_B1ms"
}
```

## Input variables

| Name | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| resource_group_name | string | — | yes | Resource group name |
| location | string | uksouth | no | Must be `uksouth` |
| tags | map(string) | — | yes | `_shared/tags` output |
| name | string | — | yes | Server name |
| postgresql_version | string | 15 | no | Major version |
| administrator_login | string | — | yes | Admin username |
| administrator_password | string | — | yes | Admin password (sensitive) |
| sku_name | string | — | yes | SKU name |
| storage_mb | number | 32768 | no | Storage size MB |
| backup_retention_days | number | 7 | no | Backup retention |
| diagnostics_settings | object | null | no | Diagnostics to LAW |

## Outputs

| Name | Type | Description |
|------|------|-------------|
| id | string | Server ID |
| name | string | Server name |
| fqdn | string | Connection FQDN |
| postgresql_flexible_server | object | Resource object |

## Policy compliance

- **Tags / location:** `uksouth` validation; `lifecycle { ignore_changes = [tags] }`.

## Versioning

Monorepo semver tags.

## Known limitations

- High availability, extensions, and firewall rules are composed separately.
