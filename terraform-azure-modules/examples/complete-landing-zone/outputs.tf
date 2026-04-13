output "resource_group_id" {
  description = "ID of the landing zone resource group."
  value       = module.rg.id
}

output "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics workspace."
  value       = module.log_analytics.id
}

output "log_analytics_customer_id" {
  description = "Workspace (customer) ID for agents."
  value       = module.log_analytics.workspace_id
}
