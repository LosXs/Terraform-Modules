output "resource_group" {
  description = "Resource group name pattern rg-{workload}-{env}-{instance}. Regional uniqueness within subscription."
  value       = "rg-${local.base_hyphen}"
}

output "virtual_network" {
  description = "Virtual network name vnet-{workload}-{env}-{instance}. Regional scope."
  value       = "vnet-${local.base_hyphen}"
}

output "subnet" {
  description = "Subnet name snet-{workload}-{env}-{instance}."
  value       = "snet-${local.base_hyphen}"
}

output "nsg" {
  description = "Network security group name nsg-{workload}-{env}-{instance}."
  value       = "nsg-${local.base_hyphen}"
}

output "route_table" {
  description = "Route table name rt-{workload}-{env}-{instance}."
  value       = "rt-${local.base_hyphen}"
}

output "private_endpoint" {
  description = "Private endpoint name pe-{workload}-{env}-{instance}. Regional scope."
  value       = "pe-${local.base_hyphen}"
}

output "private_dns_zone" {
  description = "Private DNS zone link/name fragment pdns-{workload}-{env}-{instance} (global DNS resource; name semantics depend on zone suffix)."
  value       = "pdns-${local.base_hyphen}"
}

output "key_vault" {
  description = "Key Vault name (max 24 chars, globally unique). Hyphens allowed; workload truncated if required."
  value       = local.key_vault_name
}

output "storage_account" {
  description = "Storage account name (max 24 chars, globally unique, lowercase alphanumeric only). Hyphens stripped from workload; workload truncated if required."
  value       = lower("st${local.storage_workload_part}${local.env_abbrev}${local.instance_padded}")
}

output "log_analytics" {
  description = "Log Analytics workspace name log-{workload}-{env}-{instance}."
  value       = "log-${local.base_hyphen}"
}

output "app_service_plan" {
  description = "App Service plan name asp-{workload}-{env}-{instance}."
  value       = "asp-${local.base_hyphen}"
}

output "linux_web_app" {
  description = "Linux Web App name app-{workload}-{env}-{instance} (must be globally unique within App Service)."
  value       = "app-${local.base_hyphen}"
}

output "windows_web_app" {
  description = "Windows Web App name app-{workload}-{env}-{instance} (must be globally unique within App Service)."
  value       = "wapp-${local.base_hyphen}"
}

output "function_app" {
  description = "Function App name func-{workload}-{env}-{instance} (globally unique DNS label when combined with azurewebsites.net)."
  value       = "func-${local.base_hyphen}"
}

output "container_registry" {
  description = "Azure Container Registry name (max 50 chars, alphanumeric, globally unique). Hyphens stripped from workload."
  value       = lower("cr${local.acr_workload_part}${local.env_abbrev}${local.instance_padded}")
}

output "aks_cluster" {
  description = "AKS cluster name aks-{workload}-{env}-{instance} (must be DNS-unique in region)."
  value       = "aks-${local.base_hyphen}"
}

output "container_app_env" {
  description = "Container Apps environment name cae-{workload}-{env}-{instance}."
  value       = "cae-${local.base_hyphen}"
}

output "container_app" {
  description = "Container App name ca-{workload}-{env}-{instance}."
  value       = "ca-${local.base_hyphen}"
}

output "container_app_job" {
  description = "Container App Job name caj-{workload}-{env}-{instance}."
  value       = "caj-${local.base_hyphen}"
}

output "virtual_machine" {
  description = "Virtual machine name vm-{workload}-{env}-{instance} (Windows hostnames max 15 characters; workload truncated)."
  value       = "vm-${local.vm_workload_segment}-${local.env_abbrev}-${local.instance_padded}"
}

output "mssql_server" {
  description = "Azure SQL server name sql-{workload}-{env}-{instance} (globally unique DNS name)."
  value       = "sql-${local.base_hyphen}"
}

output "postgresql_server" {
  description = "PostgreSQL flexible server name psql-{workload}-{env}-{instance} (globally unique DNS name)."
  value       = "psql-${local.base_hyphen}"
}

output "cosmosdb" {
  description = "Cosmos DB account name cosmos-{workload}-{env}-{instance} (globally unique)."
  value       = "cosmos-${local.base_hyphen}"
}

output "user_assigned_identity" {
  description = "User-assigned managed identity name id-{workload}-{env}-{instance}."
  value       = "id-${local.base_hyphen}"
}

output "action_group" {
  description = "Monitor action group name ag-{workload}-{env}-{instance}."
  value       = "ag-${local.base_hyphen}"
}

output "application_gateway" {
  description = "Application Gateway name agw-{workload}-{env}-{instance}."
  value       = "agw-${local.base_hyphen}"
}

output "public_ip" {
  description = "Public IP name pip-{workload}-{env}-{instance}."
  value       = "pip-${local.base_hyphen}"
}
