resource "azurerm_network_interface" "this" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.common_tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.this.id]
  tags                  = local.common_tags

  os_disk {
    name                 = "${var.name}-os"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image.publisher
    offer     = var.source_image.offer
    sku       = var.source_image.sku
    version   = var.source_image.version
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  disable_password_authentication = true

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.diagnostics_settings != null ? 1 : 0

  name                       = coalesce(try(var.diagnostics_settings.name, null), "${var.name}-diag")
  target_resource_id         = azurerm_linux_virtual_machine.this.id
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
