resource "azurerm_network_security_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.common_tags

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                         = security_rule.value.name
      priority                     = security_rule.value.priority
      direction                    = security_rule.value.direction
      access                       = security_rule.value.access
      protocol                     = security_rule.value.protocol
      source_port_range            = try(security_rule.value.source_port_range, null)
      destination_port_range       = try(security_rule.value.destination_port_range, null)
      source_address_prefix        = try(security_rule.value.source_address_prefix, null)
      destination_address_prefix   = try(security_rule.value.destination_address_prefix, null)
      source_port_ranges           = try(security_rule.value.source_port_ranges, null)
      destination_port_ranges      = try(security_rule.value.destination_port_ranges, null)
      source_address_prefixes      = try(security_rule.value.source_address_prefixes, null)
      destination_address_prefixes = try(security_rule.value.destination_address_prefixes, null)
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.diagnostics_settings != null ? 1 : 0

  name                       = coalesce(try(var.diagnostics_settings.name, null), "${var.name}-diag")
  target_resource_id         = azurerm_network_security_group.this.id
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
