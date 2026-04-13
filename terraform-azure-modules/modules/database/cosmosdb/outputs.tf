output "id" {
  description = "Cosmos DB account resource ID."
  value       = azurerm_cosmosdb_account.this.id
}

output "name" {
  description = "Cosmos DB account name."
  value       = azurerm_cosmosdb_account.this.name
}

output "endpoint" {
  description = "Cosmos DB endpoint."
  value       = azurerm_cosmosdb_account.this.endpoint
}

output "cosmosdb_account" {
  description = "Cosmos DB account resource object."
  value       = azurerm_cosmosdb_account.this
}
