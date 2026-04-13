resource "azurerm_private_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = local.common_tags

  dynamic "soa_record" {
    for_each = var.soa_record != null ? [var.soa_record] : []
    content {
      email        = try(soa_record.value.email, null)
      expire_time  = try(soa_record.value.expire_time, null)
      minimum_ttl  = try(soa_record.value.minimum_ttl, null)
      refresh_time = try(soa_record.value.refresh_time, null)
      retry_time   = try(soa_record.value.retry_time, null)
      ttl          = try(soa_record.value.ttl, null)
      tags         = try(soa_record.value.tags, null)
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.diagnostics_settings != null ? 1 : 0

  name                       = coalesce(try(var.diagnostics_settings.name, null), "${var.name}-diag")
  target_resource_id         = azurerm_private_dns_zone.this.id
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
