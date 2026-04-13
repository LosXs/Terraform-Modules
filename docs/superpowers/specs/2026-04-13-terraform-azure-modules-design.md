# Terraform Azure Modules Library — Design Specification

**Status:** Approved for implementation planning  
**Date:** 2026-04-13  
**Scope decision:** First consumable ADO release (**Option B**): shared foundations, governance/resource-group, monitoring (Log Analytics + diagnostic-setting), and examples `single-resource` plus a **started** `complete-landing-zone` that only references modules that exist at release time.

---

## 1. Purpose

Deliver an enterprise Terraform module monorepo (`terraform-azure-modules/`) as the organisation’s single source of truth for Azure infrastructure, aligned with HashiCorp published module practices and Microsoft Cloud Adoption Framework (CAF) naming. Modules are consumed from a shared Azure DevOps Git repository via versioned Git refs.

Platform constraints (non-negotiable):

1. **Required tags** on Resource Groups (deny) — six keys with allowed values.  
2. **Inherit tags from RG** (modify) — resources receive tags from parent RG post-apply.  
3. **UK South only** (deny) — resources must not be deployed outside `uksouth`.

Modules must not emit configurations that these policies would deny.

---

## 2. Repository layout

Use the structure defined in the product brief: root tooling (`.gitignore`, `.tflint.hcl`, `.pre-commit-config.yaml`, `CHANGELOG.md`, `README.md`), `modules/` by domain, `examples/`, `tests/README.md` (Terratest instructions stub).

Each **consumable** module directory contains: `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`, `locals.tf`, `docs/README.md`. `_shared/*` follows the same file set per brief.

**Option B note:** The full directory tree may be scaffolded early with placeholders; **first tagged release** only guarantees complete implementation for: `_shared/tags`, `_shared/naming`, `governance/resource-group`, `monitoring/log-analytics-workspace`, `monitoring/diagnostic-setting`, and the two examples below. Other module folders remain stubs until later milestones.

---

## 3. Foundation modules

### 3.1 `_shared/tags`

- **Role:** Single source of allowed values for mandatory organisational tags; outputs merged tag map for attachment to resources.  
- **Inputs:** `business_unit`, `environment`, `service`, `service_support_team`, `criticality`, `exposure` (all validated lists per brief); `additional_tags` optional map.  
- **Outputs:** `tags` (six mandatory keys + additional), `mandatory_tags` (six keys only).  
- **Keys:** Exact Azure Policy names: `BusinessUnit`, `Environment`, `Service`, `ServiceSupportTeam`, `Criticality`, `Exposure`.  
- **Validation:** `validation` blocks on each variable; error messages list allowed values in human-readable form.

### 3.2 `_shared/naming`

- **Role:** CAF-style name strings for resource types used by the library; truncation/sanitisation for global uniqueness and length limits (Key Vault, storage, ACR, VM, etc.).  
- **Inputs:** `workload` (regex: lowercase alphanumeric + hyphens, max length per brief), `environment` (same enum as tags with abbreviation mapping in `locals`), `location` default `uksouth` with validation `location == "uksouth"`, `instance` with zero-padded three-digit suffix.  
- **Outputs:** Map of string names per brief (extend with additional popular types as needed; document global uniqueness and character limits in outputs/docs).  
- **Truncation:** Deterministic order documented in module (e.g. shorten `workload` first, then apply stripping rules per resource type) so names are stable.

---

## 4. Standard module pattern (non-`_shared`)

- **Terraform:** `required_version >= 1.9.0`; `azurerm` `~> 4.0` unless an exception is documented.  
- **Variable order:** `resource_group_name` → `location` (optional, default `uksouth`, **validation** enforcing `uksouth` with policy message) → `tags` (required, no default; description references `_shared/tags`) → module-specific → `diagnostics_settings` (optional object as in brief).  
- **locals.tf:** Name from **caller** (do not call `_shared/naming` inside domain modules); `common_tags = var.tags`.  
- **main.tf:** Primary resource; supporting resources; `tags = var.tags` (or `common_tags`); `location = var.location` where applicable; dynamic blocks for optional features including diagnostics.  
- **Tags lifecycle:** `lifecycle { ignore_changes = [tags] }` on all resources **except** `governance/resource-group`, with comment referencing Policy 2 (inherit) and false drift. Resource group module **does not** ignore tag changes — it is the tag source on the RG.  
- **Location exception:** Resources that must use `global` (e.g. certain DNS/global resources) are documented in those modules with explicit comments; validation adjusted only where the brief allows.

---

## 5. First-release modules (Option B)

| Module | Responsibility |
|--------|----------------|
| `governance/resource-group` | RG with validated tags from caller; no `ignore_changes` on tags. |
| `monitoring/log-analytics-workspace` | LAW in RG; tags; optional diagnostics variable for future patterns if applicable. |
| `monitoring/diagnostic-setting` | Thin wrapper: `azurerm_monitor_diagnostic_setting` for a passed `target_resource_id`, wired to Log Analytics when configured. |

---

## 6. Examples (first release)

### 6.1 `examples/single-resource`

Minimal path: `_shared/tags` → `_shared/naming` → `governance/resource-group` only. Serves as onboarding “hello world.”

### 6.2 `examples/complete-landing-zone` (started)

Implement **only** what exists in the first release: tags, naming, resource group, and any of LAW / diagnostic-setting / stub wiring that does not require unimplemented modules. Expand this example in later milestones (VNet, Key Vault, App Service, etc.) per the master build order.

Each example includes `backend.tf` **stub** (azurerm backend block) with commented key convention: `{workload}/{environment}/{module-or-stack}.tfstate`.

---

## 7. Tooling and quality

- **Formatting/linting:** `terraform fmt -recursive`, `.tflint.hcl` with azurerm plugin, `.pre-commit-config.yaml` with fmt, validate, tflint, tfsec.  
- **Validation checklist:** Run after each module as in the product brief (outputs described, no hardcoded subscription/tenant/MG IDs in modules, etc.).  
- **Tests:** `tests/README.md` documents Terratest scaffolding; full Terratest coverage is out of scope for Option B unless time allows stub tests only.

---

## 8. Versioning and ADO consumption

- **Git tags:** `v{major}.{minor}.{patch}` on the monorepo.  
- **Module source example:**  
  `git::https://dev.azure.com/{org}/{project}/_git/terraform-azure-modules//modules/{category}/{name}?ref=vX.Y.Z`

First release tag documents exactly which modules are implemented vs scaffolded.

---

## 9. Risks and mitigations

| Risk | Mitigation |
|------|------------|
| Policy lists diverge from `_shared/tags` | Treat tag module changes as governance-sensitive; changelog + release notes. |
| Tag `ignore_changes` confuses operators | Docs state: `var.tags` still required; ignore addresses post-apply inheritance drift. |
| Truncation collisions | Document uniqueness expectations; deterministic truncation in `_shared/naming`. |
| Global vs regional location | Explicit module-level documentation and validation exceptions only where required. |

---

## 10. Out of scope for first release

Implementation of networking, compute, storage, database, app-services, containers, remaining governance/monitoring modules, full `complete-landing-zone`, and full Terratest suites — per master build order in subsequent milestones.

---

## 11. Next step

After this spec is accepted, produce a detailed **implementation plan** (build steps, file-level tasks, validation commands) using the organisation’s planning workflow, then execute in order.
