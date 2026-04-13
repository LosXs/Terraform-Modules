resource "azurerm_mssql_server" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.sql_version
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = local.common_tags

  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator != null ? [var.azuread_administrator] : []
    content {
      login_username = azuread_administrator.value.login_username
      object_id      = azuread_administrator.value.object_id
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.diagnostics_settings != null ? 1 : 0

  name                       = coalesce(try(var.diagnostics_settings.name, null), "${var.name}-diag")
  target_resource_id         = azurerm_mssql_server.this.id
  log_analytics_workspace_id = var.diagnostics_settings.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = var.diagnostics_settings != null && var.diagnostics_settings.logs_enabled ? toset(["allLogs"]) : toset([])
    content {
      category_group = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = var.diagnostics_settings != null && var.diagnostics_settings.metrics_enabled ? [1] : []
    content {
      category = "AllMetrics"
      enabled  = true
    }
  }
}
