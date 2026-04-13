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

output "virtual_network_id" {
  description = "Resource ID of the hub/spoke virtual network."
  value       = module.vnet.id
}

output "subnet_id" {
  description = "Resource ID of the primary workload subnet."
  value       = module.subnet.id
}

output "network_security_group_id" {
  description = "Resource ID of the workload NSG."
  value       = module.nsg.id
}
