# Key Vault key

> Deploys `azurerm_key_vault_key` in an existing Key Vault. Defaults to RSA with configurable size; set `key_type = "EC"` for elliptic curve keys.

## Overview

The vault must exist and the deploying principal must have rights to create keys (typically Key Vault Crypto Officer with RBAC-enabled vaults). Pass `tags` from `_shared/tags` for consistency.

## Architecture diagram

```mermaid
flowchart LR
  KV[Key Vault]
  K[azurerm_key_vault_key]
  KV --> K
```

## Usage

```hcl
module "kvk" {
  source = "../../modules/identity-security/key-vault-key"

  key_vault_id = module.kv.key_vault.id
  name         = "encryption-key"
  tags         = module.tags.tags
}
```

## Input variables

| Name | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| key_vault_id | string | — | yes | Key Vault resource ID |
| name | string | — | yes | Key name |
| key_type | string | RSA | no | RSA or EC |
| key_size | number | 2048 | no | RSA key size in bits |
| key_opts | list(string) | see variables.tf | no | Permitted operations |
| tags | map(string) | — | yes | `_shared/tags` output |

## Outputs

| Name | Type | Description |
|------|------|-------------|
| id | string | Key ID |
| name | string | Key name |
| version | string | Current version |
| key_vault_key | object | Resource object |

## Policy compliance

- **Tags:** `lifecycle { ignore_changes = [tags] }` on the key where configured.

## Versioning

Monorepo semver tags.

## Known limitations

- Key rotation policies and automated rotation are not modeled in this minimal module.
