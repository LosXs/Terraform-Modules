output "id" {
  description = "The route table resource ID."
  value       = azurerm_route_table.this.id
}

output "name" {
  description = "The route table name."
  value       = azurerm_route_table.this.name
}

output "route_table" {
  description = "The route table resource object."
  value       = azurerm_route_table.this
}
