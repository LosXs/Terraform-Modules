resource "azurerm_key_vault_key" "this" {
  name         = var.name
  key_vault_id = var.key_vault_id
  key_type     = var.key_type
  key_size     = var.key_type == "RSA" ? var.key_size : null
  key_opts     = var.key_opts
  tags         = local.common_tags

  lifecycle {
    ignore_changes = [tags]
  }
}
