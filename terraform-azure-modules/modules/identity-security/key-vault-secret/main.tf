resource "azurerm_key_vault_secret" "this" {
  name         = var.name
  value        = var.value
  key_vault_id = var.key_vault_id
  content_type = var.content_type
  tags         = local.common_tags

  # Azure Policy "Inherit Tags from Resource Group" may adjust tags post-apply.
  lifecycle {
    ignore_changes = [tags]
  }
}
