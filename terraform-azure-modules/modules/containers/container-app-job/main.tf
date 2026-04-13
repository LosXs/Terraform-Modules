resource "azurerm_container_app_job" "this" {
  name                         = var.name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  replica_timeout_in_seconds   = var.replica_timeout_in_seconds
  replica_retry_limit          = var.replica_retry_limit
  tags                         = local.common_tags

  template {
    container {
      name   = var.container_name
      image  = var.image
      cpu    = var.cpu
      memory = var.memory
    }
  }

  dynamic "manual_trigger_config" {
    for_each = local.use_schedule ? [] : [1]
    content {
      parallelism              = coalesce(var.manual_trigger_config.parallelism, 1)
      replica_completion_count = coalesce(var.manual_trigger_config.replica_completion_count, 1)
    }
  }

  dynamic "schedule_trigger_config" {
    for_each = local.use_schedule ? [var.schedule_trigger_config] : []
    content {
      cron_expression          = schedule_trigger_config.value.cron_expression
      parallelism              = coalesce(schedule_trigger_config.value.parallelism, 1)
      replica_completion_count = coalesce(schedule_trigger_config.value.replica_completion_count, 1)
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.diagnostics_settings != null ? 1 : 0

  name                       = coalesce(try(var.diagnostics_settings.name, null), "${var.name}-diag")
  target_resource_id         = azurerm_container_app_job.this.id
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
