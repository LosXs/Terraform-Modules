resource "azurerm_private_endpoint" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = local.common_tags

  private_service_connection {
    name                           = var.private_connection_name
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.subresource_names
    is_manual_connection           = var.is_manual_connection
    request_message                = var.request_message
  }

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group != null ? [var.private_dns_zone_group] : []
    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.diagnostics_settings != null ? 1 : 0

  name                       = coalesce(try(var.diagnostics_settings.name, null), "${var.name}-diag")
  target_resource_id         = azurerm_private_endpoint.this.id
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
