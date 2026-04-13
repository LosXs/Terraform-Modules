# azurerm_monitor_diagnostic_setting does not support Azure resource tags or a location.
# Policy compliance for tags is inherited from the monitored resource and destination workspace context.

variable "name" {
  description = "Name of the diagnostic setting."
  type        = string
}

variable "target_resource_id" {
  description = "Azure resource ID of the resource to monitor (log and metric source)."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Resource ID of the Log Analytics workspace that receives logs and metrics."
  type        = string
}

variable "log_category_groups" {
  description = "Diagnostic log category groups to enable (e.g. allLogs)."
  type        = list(string)
  default     = ["allLogs"]
}

variable "enable_metrics" {
  description = "When true, enables the AllMetrics category for this diagnostic setting."
  type        = bool
  default     = true
}
