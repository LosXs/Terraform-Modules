output "id" {
  description = "The NSG resource ID."
  value       = azurerm_network_security_group.this.id
}

output "name" {
  description = "The NSG name."
  value       = azurerm_network_security_group.this.name
}

output "network_security_group" {
  description = "The NSG resource object."
  value       = azurerm_network_security_group.this
}
