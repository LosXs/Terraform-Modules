output "id" {
  description = "Host pool resource ID."
  value       = azurerm_virtual_desktop_host_pool.this.id
}

output "name" {
  description = "Host pool name."
  value       = azurerm_virtual_desktop_host_pool.this.name
}

output "host_pool" {
  description = "Host pool resource object."
  value       = azurerm_virtual_desktop_host_pool.this
}
