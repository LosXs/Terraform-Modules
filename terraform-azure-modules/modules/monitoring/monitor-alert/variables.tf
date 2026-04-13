variable "resource_group_name" {
  description = "Resource group for the metric alert."
  type        = string
}

variable "tags" {
  description = "Must be the output of the _shared/tags module."
  type        = map(string)
}

variable "name" {
  description = "Alert rule name."
  type        = string
}

variable "scopes" {
  description = "Monitored resource IDs (e.g. storage account, VM)."
  type        = list(string)
}

variable "enabled" {
  description = "Whether the alert is enabled."
  type        = bool
  default     = true
}

variable "severity" {
  description = "Alert severity 0–4."
  type        = number
  default     = 2
}

variable "frequency" {
  description = "Evaluation frequency ISO8601 (e.g. PT1M)."
  type        = string
  default     = "PT1M"
}

variable "window_size" {
  description = "Aggregation window ISO8601 (e.g. PT5M)."
  type        = string
  default     = "PT5M"
}

variable "metric_namespace" {
  description = "Metric namespace for the monitored resource."
  type        = string
}

variable "metric_name" {
  description = "Metric name."
  type        = string
}

variable "aggregation" {
  description = "Aggregation type (Average, Total, etc.)."
  type        = string
}

variable "operator" {
  description = "Comparison operator."
  type        = string
}

variable "threshold" {
  description = "Threshold value."
  type        = number
}

variable "action_group_id" {
  description = "Action group resource ID to notify."
  type        = string
}
