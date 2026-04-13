resource "azurerm_management_group" "this" {
  name                       = var.name
  display_name               = var.display_name
  parent_management_group_id = var.parent_management_group_id
  subscription_ids           = length(var.subscription_ids) > 0 ? var.subscription_ids : null
}
