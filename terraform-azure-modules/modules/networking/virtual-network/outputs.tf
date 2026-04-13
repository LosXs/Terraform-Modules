output "id" {
  description = "The Azure resource ID of the virtual network."
  value       = azurerm_virtual_network.this.id
}

output "name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.this.name
}

output "virtual_network" {
  description = "The virtual network resource object."
  value       = azurerm_virtual_network.this
}
