resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = var.name
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = toset(local.log_groups)
    content {
      category_group = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = var.enable_metrics ? [1] : []
    content {
      category = "AllMetrics"
      enabled  = true
    }
  }
}
