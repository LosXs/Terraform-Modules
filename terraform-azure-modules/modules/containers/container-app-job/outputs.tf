output "id" {
  description = "Container app job resource ID."
  value       = azurerm_container_app_job.this.id
}

output "name" {
  description = "Job name."
  value       = azurerm_container_app_job.this.name
}

output "container_app_job" {
  description = "Job resource object."
  value       = azurerm_container_app_job.this
}
