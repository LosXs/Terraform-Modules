resource "azurerm_virtual_desktop_host_pool" "this" {
  name                 = var.host_pool_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  type                 = var.host_pool_type
  load_balancer_type   = var.load_balancer_type
  validate_environment = var.validate_environment
  tags                 = local.common_tags

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.diagnostics_settings != null ? 1 : 0

  name                       = coalesce(try(var.diagnostics_settings.name, null), "${var.host_pool_name}-diag")
  target_resource_id         = azurerm_virtual_desktop_host_pool.this.id
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
