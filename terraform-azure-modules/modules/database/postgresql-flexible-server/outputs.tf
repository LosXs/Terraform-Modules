output "id" {
  description = "PostgreSQL flexible server resource ID."
  value       = azurerm_postgresql_flexible_server.this.id
}

output "name" {
  description = "Server name."
  value       = azurerm_postgresql_flexible_server.this.name
}

output "fqdn" {
  description = "Server FQDN."
  value       = azurerm_postgresql_flexible_server.this.fqdn
}

output "postgresql_flexible_server" {
  description = "Server resource object."
  value       = azurerm_postgresql_flexible_server.this
}
