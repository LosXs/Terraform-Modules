# Terraform Azure Modules Library (Option B) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development` (recommended) or `superpowers:executing-plans` to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Scaffold the full `terraform-azure-modules/` tree, fully implement `_shared/tags`, `_shared/naming`, `governance/resource-group`, `monitoring/log-analytics-workspace`, `monitoring/diagnostic-setting`, stub all other module paths, add `examples/single-resource` and a **started** `examples/complete-landing-zone`, plus root tooling (`CHANGELOG`, `.gitignore`, `.tflint.hcl`, `.pre-commit-config.yaml`, `README.md`, `tests/README.md`), and verify with `terraform fmt`, `terraform validate`, `tflint`, and `tfsec` where applicable.

**Architecture:** Consumers compose `_shared/tags` (policy-aligned validation) and `_shared/naming` (CAF strings) at the stack level, then pass `tags` and caller-built `name` into domain modules. Domain modules stay decoupled from shared modules, enforce `location = "uksouth"`, require `tags`, and use `lifecycle { ignore_changes = [tags] }` on all resources **except** `governance/resource-group`. Examples use relative `source = "../../modules/..."` and include commented `backend.tf` stubs.

**Tech Stack:** Terraform `>= 1.9.0`, HashiCorp `azurerm` provider `~> 4.0`, TFLint with Azure rules, tfsec, pre-commit.

**Canonical paths:** All library code lives under `terraform-azure-modules/` at the repository root (sibling to `docs/`). Adjust paths if the monorepo root differs.

---

## File structure map (create or touch)

| Area | Paths |
|------|--------|
| Root | `terraform-azure-modules/.gitignore`, `.tflint.hcl`, `.pre-commit-config.yaml`, `CHANGELOG.md`, `README.md` |
| Tests | `terraform-azure-modules/tests/README.md` |
| Shared | `modules/_shared/tags/*`, `modules/_shared/naming/*` (each: `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`, `locals.tf`, `docs/README.md`) |
| Implemented v0.1 | `modules/governance/resource-group/*`, `modules/monitoring/log-analytics-workspace/*`, `modules/monitoring/diagnostic-setting/*` |
| Stubs | All other `modules/**` directories from the product brief (governance/management-group, policy-assignment; full networking, compute, storage, database, identity-security except as needed, app-services, containers) — each with the six standard files + `docs/README.md` stub |
| Examples | `examples/single-resource/*`, `examples/complete-landing-zone/*` (plus `aks-workload/`, `web-app-with-db/` as minimal stubs or README-only placeholders per YAGNI for Option B — **omit** extra example folders if not in spec; spec lists four example dirs — create all four: `aks-workload` and `web-app-with-db` contain only `README.md` stating “Not implemented in v0.1”) |

**Stub `docs/README.md` minimum:** Title, one sentence “Scaffold only; not implemented in v0.1.”, link to repo root README.

---

## Validation commands (repeat after each implemented module and at end)

From `terraform-azure-modules/`:

```bash
terraform fmt -recursive -check
terraform fmt -recursive
```

From each **implemented** module directory and each **example** directory (after `terraform init -backend=false`):

```bash
cd terraform-azure-modules/modules/<path>
terraform init -backend=false
terraform validate
```

From repo root (after installing tflint plugins if needed):

```bash
cd terraform-azure-modules
tflint --init
tflint
tfsec . --soft-fail
```

**Expected:** `fmt` clean; `validate` success; `tflint` no errors; address any `tfsec` findings or document suppressions with inline comments only when justified.

---

### Task 1: Create root `terraform-azure-modules/` and tooling files

**Files:**

- Create: `terraform-azure-modules/.gitignore`
- Create: `terraform-azure-modules/.tflint.hcl`
- Create: `terraform-azure-modules/.pre-commit-config.yaml`
- Create: `terraform-azure-modules/CHANGELOG.md`
- Create: `terraform-azure-modules/tests/README.md`

- [ ] **Step 1.1: Add `.gitignore`**

Use standard Terraform ignores:

```gitignore
# Local .terraform directories
**/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*

# Crash log files
crash.log
crash.*.log

*.tfvars
*.tfvars.json

override.tf
override.tf.json
*_override.tf
*_override.tf.json

.terraformrc
terraform.rc
```

- [ ] **Step 1.2: Add `.tflint.hcl`**

```hcl
plugin "azurerm" {
  enabled = true
  version = "0.27.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}
```

- [ ] **Step 1.3: Add `.pre-commit-config.yaml`**

```yaml
repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.96.1
    hooks:
      - id: terraform_fmt
      - id: terraform_validate
      - id: terraform_tflint
      - id: terraform_tfsec
```

- [ ] **Step 1.4: Add `CHANGELOG.md`**

Keep a Changelog format, initial entry:

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial scaffold and v0.1 modules: `_shared/tags`, `_shared/naming`, `governance/resource-group`, `monitoring/log-analytics-workspace`, `monitoring/diagnostic-setting`, examples `single-resource` and started `complete-landing-zone`.
```

- [ ] **Step 1.5: Add `tests/README.md` (Terratest stub)**

```markdown
# Tests

Terratest integration tests are not yet implemented for v0.1.

## Planned layout

- Go module at `tests/` with build tags.
- Each example under `examples/` will have a matching test that runs `terraform.InitAndApply` against a disposable subscription or test harness (organisation-specific).

## Running (future)

```bash
cd tests
go test -v -timeout 30m ./...
```

CI should set `ARM_*` environment variables for Azure authentication non-interactively.
```

- [ ] **Step 1.6: Run `terraform fmt`**

No `.tf` files yet — skip or run from parent; confirm no error.

---

### Task 2: Scaffold all module directories (stubs + six files each)

**Files:** Every path under `terraform-azure-modules/modules/` per product brief, including `_shared/tags` and `_shared/naming` (will overwrite in Tasks 3–4).

For **each** stub directory, create:

- `versions.tf` (identical template below)
- `variables.tf` (placeholder comment)
- `main.tf` (scaffold comment only)
- `outputs.tf` (placeholder comment)
- `locals.tf` (`locals { }` or minimal comment)
- `docs/README.md` (stub sentence)

**Template `versions.tf` for stub modules:**

```hcl
terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
```

**Template `main.tf`:**

```hcl
# Scaffold only — no resources in v0.1. See docs/README.md.
```

**Directories to create (exact list):**

- `modules/_shared/tags`, `modules/_shared/naming`
- `modules/governance/resource-group`, `modules/governance/management-group`, `modules/governance/policy-assignment`
- `modules/networking/virtual-network`, `subnet`, `network-security-group`, `private-endpoint`, `private-dns-zone`, `route-table`
- `modules/compute/virtual-machine`, `virtual-machine-scale-set`, `azure-virtual-desktop`
- `modules/storage/storage-account`, `file-share`
- `modules/database/mssql-server`, `mssql-database`, `postgresql-flexible-server`, `cosmosdb`
- `modules/identity-security/key-vault`, `key-vault-secret`, `key-vault-key`, `role-assignment`, `user-assigned-identity`
- `modules/monitoring/log-analytics-workspace`, `diagnostic-setting`, `action-group`, `monitor-alert`
- `modules/app-services/app-service-plan`, `linux-web-app`, `windows-web-app`, `function-app`
- `modules/containers/container-registry`, `aks-cluster`, `container-app-environment`, `container-app`, `container-app-job`

Optional extra service folders: add `modules/integration/service-bus`, `modules/integration/event-grid` only if you want future expansion — **YAGNI:** omit unless the organisation brief required them; the approved spec does not require extra folders beyond the brief.

- [ ] **Step 2.1:** Create directory tree and stub files (script or manual).
- [ ] **Step 2.2:** Run `terraform fmt -recursive` on `terraform-azure-modules/modules`.

---

### Task 3: Implement `modules/_shared/tags`

**Files:**

- Replace: `terraform-azure-modules/modules/_shared/tags/versions.tf`
- Replace: `terraform-azure-modules/modules/_shared/tags/variables.tf`
- Replace: `terraform-azure-modules/modules/_shared/tags/locals.tf`
- Replace: `terraform-azure-modules/modules/_shared/tags/main.tf`
- Replace: `terraform-azure-modules/modules/_shared/tags/outputs.tf`
- Replace: `terraform-azure-modules/modules/_shared/tags/docs/README.md`

**Allowed value lists** (must match Azure Policy exactly; error messages must enumerate allowed values):

**business_unit:** `AVM Team`, `B2C`, `Clients`, `Customer Care`, `Data (MI)`, `Field Operations`, `Field Operations B2C`, `Field Operations Central Operations`, `IT`, `Procurement`, `Risk & Audit`

**environment:** `Production`, `Staging`, `Test`, `Development`, `Disaster Recovery`

**service:** `Shared Services`, `AD Management`, `Affiliates`, `Audit`, `Autopilot`, `AVM`, `Azure Workstations`, `Backup`, `Certificate Services`, `Cladding`, `Cloudflare`, `Cognos`, `Complaints`, `Compute Gateway`, `CRM`, `EDR`, `Equipment Portal`, `Fees`, `File Repo`, `Firewall`, `FOS`, `FTP`, `HB terms`, `Infrastructure Workstations`, `KEP`, `KMS`, `M2L Discrepency`, `MI Data Gateway`, `MI System`, `Monitoring`, `NBCM`, `Non-Trad API`, `PAL`, `PAM`, `Patch Management`, `Print Services`, `Quest`, `Risk Server`, `RPA`, `SIEM`, `Surveyor Workstations`, `Testing Automation`, `Vulnerability Scanning`, `WFS Terms`

**service_support_team:** `IT`, `AVM Team`, `Business Solutions`, `Data Connect`, `Data (MI)`

**criticality:** `Critical`, `Important`, `Low`

**exposure:** `Internal`, `External`, `Public`

- [ ] **Step 3.1: Write `variables.tf`** with `validation` blocks using `contains()` against `local` or inline lists; set `additional_tags` default `{}`.

- [ ] **Step 3.2: Write `locals.tf`** to build `mandatory_tags` map with keys exactly: `BusinessUnit`, `Environment`, `Service`, `ServiceSupportTeam`, `Criticality`, `Exposure`.

- [ ] **Step 3.3: Write `main.tf`** — can be empty if all logic is locals/outputs; or use `terraform` block only in `versions.tf`.

- [ ] **Step 3.4: Write `outputs.tf`**

```hcl
output "mandatory_tags" {
  description = "The six mandatory organisational tags (Azure Policy key names)."
  value       = local.mandatory_tags
}

output "tags" {
  description = "Mandatory tags merged with additional_tags."
  value       = merge(local.mandatory_tags, var.additional_tags)
}
```

- [ ] **Step 3.5: Write `docs/README.md`** using the organisation’s required section template (Overview, Mermaid flowchart inputs → validation → outputs, Prerequisites, Usage minimal + production + ADO YAML, variable table, outputs table, Policy compliance, Resource naming N/A, Versioning, Known limitations).

- [ ] **Step 3.6:** `terraform init -backend=false && terraform validate` in `modules/_shared/tags`.

---

### Task 4: Implement `modules/_shared/naming`

**Files:** Replace all six files under `modules/_shared/naming/`.

**Logic requirements:**

- `workload`: `validation` regex `^[-a-z0-9]{1,12}$` (or stricter: alphanumeric + hyphens only).
- `environment`: same allowed list as tags; `locals` map: Production→`prod`, Staging→`stg`, Test→`tst`, Development→`dev`, Disaster Recovery→`dr`.
- `location`: default `"uksouth"`; `validation` `var.location == "uksouth"`.
- `instance`: number, default `1`; format `format("%03d", var.instance)`.
- Base suffix pattern: `{workload}-{env_abbrev}-{instance_padded}` with hyphens where the naming pattern uses hyphens.

**Outputs** (all strings): include at minimum: `resource_group`, `virtual_network`, `subnet`, `nsg`, `key_vault`, `storage_account`, `log_analytics`, `app_service_plan`, `linux_web_app`, `function_app`, `container_registry`, `aks_cluster`, `container_app_env`, `container_app`, `container_app_job`, `virtual_machine`, `mssql_server`, `postgresql_server`, `cosmosdb`, `user_assigned_identity`, `action_group`, plus any brief-listed types.

**Truncation helpers in `locals.tf`:**

- Define `workload_safe` = lower(replace(var.workload, "-", "")) where hyphens must be stripped (storage, ACR).
- For Key Vault (`kv-{workload}-{env}-{instance}`): max 24 chars, alphanumeric + hyphens — implement `substr` logic: shorten `workload` deterministically (e.g. max segment lengths) until length OK.
- Storage: `st` + `workload_safe` + `env` + `instance_padded` ≤ 24, lowercase alphanumeric only.
- ACR: `cr` + `workload_safe` + `env` + `instance_padded` ≤ 50, alphanumeric only.
- VM Windows name ≤ 15: truncate composite name.

Document each constraint in `outputs.tf` descriptions and in `docs/README.md` “Resource naming”.

- [ ] **Step 4.1:** Implement `variables.tf`, `locals.tf`, `main.tf` (empty if unused), `outputs.tf`.
- [ ] **Step 4.2:** Complete `docs/README.md` with Mermaid diagram and examples.
- [ ] **Step 4.3:** `terraform validate` in module directory.

---

### Task 5: Implement `modules/governance/resource-group`

**Pattern:** `azurerm_resource_group` with `name` = `var.name` (caller-supplied), `location` = `var.location`, `tags` = `var.tags`. **Do not** add `lifecycle { ignore_changes = [tags] }` — RG is tag source.

**Files:** `variables.tf`, `locals.tf`, `main.tf`, `outputs.tf`, `versions.tf`, `docs/README.md`

**Variable order:**

1. `name` (string, required) — resource group name from caller naming module.
2. `location` (string, optional, default `uksouth`, validation `var.location == "uksouth"`).
3. `tags` (required map(string), description referencing `_shared/tags` output and Policy 1).

No `diagnostics_settings` on RG unless product owner requires — **omit** for RG (not applicable); state in docs “N/A for Resource Group.”

- [ ] **Step 5.1:** Implement Terraform and docs (Mermaid: tags + naming → RG).
- [ ] **Step 5.2:** `terraform validate`.

---

### Task 6: Implement `modules/monitoring/log-analytics-workspace`

**Resources:** `azurerm_log_analytics_workspace` with `name`, `resource_group_name`, `location`, `tags`, sensible defaults for `sku` (`PerGB2018`) and `retention_in_days` (e.g. 30).

**Variables:** Standard order: `resource_group_name`, `location`, `tags`, then `name` (required), optional `sku`, `retention_in_days`, then `diagnostics_settings` object.

**Note:** Forwarding LAW logs to another workspace via diagnostic settings is uncommon; still include `diagnostics_settings` with dynamic `azurerm_monitor_diagnostic_setting` when non-null, targeting the workspace ID — if circular, **document** that `diagnostics_settings` should remain `null` for LAW in most cases.

- [ ] **Step 6.1:** Implement with `lifecycle { ignore_changes = [tags] }` on the LAW resource.
- [ ] **Step 6.2:** Outputs: `id`, `name`, `workspace_id` (primary `id` or `workspace_id` attribute per provider — use attribute that diagnostic settings expect for Log Analytics).
- [ ] **Step 6.3:** Docs + validate.

---

### Task 7: Implement `modules/monitoring/diagnostic-setting`

**Resource:** `azurerm_monitor_diagnostic_setting`.

**Variables:**

1. `name` (string, required) — diagnostic setting name.
2. `target_resource_id` (string, required) — ID of the monitored resource.
3. `log_analytics_workspace_id` (string, required) — destination LAW.
4. Optional: `log_categories` / `metric_categories` or use `enabled_log` / `metric` blocks with sensible defaults to enable all logs/metrics where provider supports `enabled_log { }` dynamic blocks — align with azurerm 4.x schema (`enabled_log` block).

**Deviation from generic variable order:** User spec orders `resource_group_name`, `location`, `tags` first. Diagnostic settings do not support tags/locations. **Resolution:** Prefix module with a comment block: “This resource does not support Azure tags or location; Policy compliance is inherited via target resource and Log Analytics.” Then declare only variables that exist — do **not** invent fake `location`/`tags` required variables. Include `versions.tf` only.

**Implementation:** Use dynamic `enabled_log` for optional category lists; default enable all by using `dynamic` with `for_each` from data source — user said avoid data sources inside modules where possible — **use** `variable "enabled_log_category_groups" default ["allLogs"]` or provider-documented approach for “all logs” in azurerm 4.

Minimal viable: static blocks or `dynamic "enabled_log" { for_each = toset(var.log_category_groups) ... }` with variable default `["allLogs"]` if supported.

- [ ] **Step 7.1:** Implement `main.tf`, `variables.tf`, `outputs.tf` (`id`, `name`), `locals.tf`, `versions.tf`, `docs/README.md` explaining tag exception.
- [ ] **Step 7.2:** `terraform validate`.

---

### Task 8: `examples/single-resource`

**Files:**

- `terraform-azure-modules/examples/single-resource/main.tf`
- `terraform-azure-modules/examples/single-resource/variables.tf` (optional)
- `terraform-azure-modules/examples/single-resource/outputs.tf`
- `terraform-azure-modules/examples/single-resource/versions.tf`
- `terraform-azure-modules/examples/single-resource/backend.tf` (comment block + stub backend)
- `terraform-azure-modules/examples/single-resource/README.md` (how to run)

**Pattern:**

```hcl
module "tags" {
  source = "../../modules/_shared/tags"
  # ... all six inputs with example values matching design: IT, Development, Monitoring, IT, Important, Internal
}

module "naming" {
  source     = "../../modules/_shared/naming"
  workload   = "landingzone"
  environment = "Development"
}

module "rg" {
  source              = "../../modules/governance/resource-group"
  name                = module.naming.resource_group
  location            = "uksouth"
  tags                = module.tags.tags
}
```

Use `workload` length ≤ 12; `landingzone` is 11 chars — OK.

- [ ] **Step 8.1:** Add `provider "azurerm" { features {} }` in `versions.tf` or `main.tf` with `subscription_id` via env var only (no hardcoded IDs).
- [ ] **Step 8.2:** `terraform init -backend=false`, `terraform validate`.
- [ ] **Step 8.3:** `README.md` with apply/destroy cautions.

---

### Task 9: `examples/complete-landing-zone` (started)

**Include only:** `tags`, `naming`, `resource-group`, `log-analytics-workspace`, optional `diagnostic-setting` from web app — **no web app in v0.1**, so wire **diagnostic setting from LAW** only if non-circular, or **omit** diagnostic chaining and only deploy RG + LAW.

**Minimal safe stack:** tags → naming → rg → law (same tags; law name from `module.naming.log_analytics`). Optionally add `diagnostic-setting` targeting a **different** resource — if none exists, **do not** add diagnostic-setting module in this example; document “Diagnostic setting to LAW for additional resources will be added when compute modules ship.”

- [ ] **Step 9.1:** Implement `main.tf`, `versions.tf`, `backend.tf` stub, `README.md`.
- [ ] **Step 9.2:** `terraform validate`.

---

### Task 10: Other example folders (placeholders)

- [ ] **Step 10.1:** Create `examples/aks-workload/README.md` and `examples/web-app-with-db/README.md` stating “Example not implemented in v0.1; see CHANGELOG and root README roadmap.”

---

### Task 11: Root `terraform-azure-modules/README.md`

- [ ] **Step 11.1:** Document purpose, how to consume from ADO (`git::https://dev.azure.com/...`), module index table (**Implemented v0.1** vs **Scaffold**), validation checklist pointer, and a **Mermaid** `graph TD` extending the product brief diagram to list all module nodes (implemented vs dashed/scaffold styling in caption).

---

### Task 12: Final verification and CHANGELOG touch

- [ ] **Step 12.1:** Run `terraform fmt -recursive`, `tflint --init && tflint`, `tfsec` from `terraform-azure-modules/`.
- [ ] **Step 12.2:** Confirm no subscription IDs, tenant IDs, or RG names in **modules** (only examples/backend comments).
- [ ] **Step 12.3:** Update `CHANGELOG.md` `[Unreleased]` with concrete file list if needed; prepare tag message for `v0.1.0` when ready ( tagging is a human/CI step).

---

## Spec coverage self-review

| Spec item | Task |
|-----------|------|
| Full tree scaffold | Task 2 |
| `_shared/tags` lists + outputs | Task 3 |
| `_shared/naming` + truncation | Task 4 |
| RG without tag ignore | Task 5 |
| LAW + diagnostics variable | Task 6 |
| Diagnostic-setting wrapper | Task 7 |
| Examples + backend stub | Tasks 8–10 |
| Tooling | Tasks 1, 12 |
| Tests README stub | Task 1 |
| Root README + Mermaid | Task 11 |

**Gap closed:** Diagnostic-setting module variable order exception documented in Task 7 to avoid fake `tags`/`location` on unsupported resource.

---

## Execution handoff

Plan complete and saved to `docs/superpowers/plans/2026-04-13-terraform-azure-modules.md`.

**Two execution options:**

1. **Subagent-driven (recommended)** — Dispatch a fresh subagent per task, review between tasks, fast iteration. **Required sub-skill:** `superpowers:subagent-driven-development`.

2. **Inline execution** — Execute tasks in this session with checkpoints. **Required sub-skill:** `superpowers:executing-plans`.

**Which approach do you want?**
