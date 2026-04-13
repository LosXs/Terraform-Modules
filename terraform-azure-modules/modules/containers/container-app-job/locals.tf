locals {
  common_tags  = var.tags
  use_schedule = var.schedule_trigger_config != null
}
