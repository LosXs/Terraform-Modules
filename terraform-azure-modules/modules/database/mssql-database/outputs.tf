output "id" {
  description = "Database resource ID."
  value       = azurerm_mssql_database.this.id
}

output "name" {
  description = "Database name."
  value       = azurerm_mssql_database.this.name
}

output "mssql_database" {
  description = "Database resource object."
  value       = azurerm_mssql_database.this
}
