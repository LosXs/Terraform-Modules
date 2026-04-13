resource "azurerm_monitor_metric_alert" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  enabled             = var.enabled
  severity            = var.severity
  frequency           = var.frequency
  window_size         = var.window_size
  tags                = local.common_tags

  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = var.metric_name
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.threshold
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
