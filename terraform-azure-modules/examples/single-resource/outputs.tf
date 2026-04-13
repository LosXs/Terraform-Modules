output "resource_group_id" {
  description = "ID of the created resource group."
  value       = module.rg.id
}

output "resource_group_name" {
  description = "Name of the created resource group."
  value       = module.rg.name
}
