locals {
  allowed_environments = [
    "Production",
    "Staging",
    "Test",
    "Development",
    "Disaster Recovery",
  ]

  environment_abbreviations = {
    "Production"        = "prod"
    "Staging"           = "stg"
    "Test"              = "tst"
    "Development"       = "dev"
    "Disaster Recovery" = "dr"
  }

  env_abbrev      = local.environment_abbreviations[var.environment]
  instance_padded = format("%03d", var.instance)

  # Hyphenated segment used across most CAF-style names: {workload}-{env}-{instance}
  base_hyphen = "${var.workload}-${local.env_abbrev}-${local.instance_padded}"

  # Lowercase alphanumeric only (storage accounts, ACR, etc.)
  workload_alnum = replace(var.workload, "-", "")

  # --- Length-constrained names (deterministic truncation: shorten workload first) ---

  instance_digits = 3

  # Key Vault: max 24 chars globally; alphanumeric and hyphens. Pattern: kv-{workload}-{env}-{instance}
  key_vault_fixed_chars  = 3 + 1 + length(local.env_abbrev) + 1 + local.instance_digits # kv- + workload + - + env + - + inst
  key_vault_workload_max = max(1, 24 - local.key_vault_fixed_chars)
  key_vault_workload     = substr(var.workload, 0, min(length(var.workload), local.key_vault_workload_max))
  key_vault_name         = "kv-${local.key_vault_workload}-${local.env_abbrev}-${local.instance_padded}"

  # Storage account: max 24; lowercase letters and digits only; no hyphens in name.
  storage_body_max     = 24 - 2 # "st"
  storage_tail         = "${local.env_abbrev}${local.instance_padded}"
  storage_workload_max = max(0, local.storage_body_max - length(local.storage_tail))
  storage_workload_part = substr(
    local.workload_alnum,
    0,
    min(length(local.workload_alnum), local.storage_workload_max)
  )

  # ACR: max 50; alphanumeric only.
  acr_body_max     = 50 - 2 # "cr"
  acr_workload_max = max(0, local.acr_body_max - length(local.storage_tail))
  acr_workload_part = substr(
    local.workload_alnum,
    0,
    min(length(local.workload_alnum), local.acr_workload_max)
  )

  # Windows computer / VM name: max 15 characters for legacy Windows hostnames. Pattern vm-{workload}-{env}-{instance}
  vm_fixed_chars      = 3 + 1 + length(local.env_abbrev) + 1 + local.instance_digits # vm- + workload + - + env + - + inst
  vm_workload_max     = max(1, 15 - local.vm_fixed_chars)
  vm_workload_segment = substr(var.workload, 0, min(length(var.workload), local.vm_workload_max))
}
