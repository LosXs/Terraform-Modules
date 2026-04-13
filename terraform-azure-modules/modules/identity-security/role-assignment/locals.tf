locals {
  use_name = var.role_definition_id == null && var.role_definition_name != null
  use_id   = var.role_definition_id != null && var.role_definition_name == null
}
