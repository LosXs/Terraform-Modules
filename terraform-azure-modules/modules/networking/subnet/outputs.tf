output "id" {
  description = "The subnet ID."
  value       = azurerm_subnet.this.id
}

output "name" {
  description = "The subnet name."
  value       = azurerm_subnet.this.name
}

output "subnet" {
  description = "The subnet resource object."
  value       = azurerm_subnet.this
}
