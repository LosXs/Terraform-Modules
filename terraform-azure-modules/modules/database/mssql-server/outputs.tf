output "id" {
  description = "SQL server resource ID."
  value       = azurerm_mssql_server.this.id
}

output "name" {
  description = "SQL server name."
  value       = azurerm_mssql_server.this.name
}

output "fqdn" {
  description = "Fully qualified domain name of the SQL server."
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "mssql_server" {
  description = "SQL server resource object."
  value       = azurerm_mssql_server.this
}
