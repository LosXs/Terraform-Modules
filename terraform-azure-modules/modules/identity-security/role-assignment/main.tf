resource "azurerm_role_assignment" "this" {
  scope        = var.scope
  principal_id = var.principal_id

  role_definition_name = local.use_name ? var.role_definition_name : null
  role_definition_id   = local.use_id ? var.role_definition_id : null

  description = var.description

  lifecycle {
    precondition {
      condition     = local.use_name || local.use_id
      error_message = "Provide exactly one of role_definition_name or role_definition_id."
    }
  }
}
