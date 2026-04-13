output "id" {
  description = "Virtual machine resource ID."
  value       = azurerm_linux_virtual_machine.this.id
}

output "name" {
  description = "Virtual machine name."
  value       = azurerm_linux_virtual_machine.this.name
}

output "network_interface_id" {
  description = "NIC resource ID."
  value       = azurerm_network_interface.this.id
}

output "virtual_machine" {
  description = "Linux virtual machine resource object."
  value       = azurerm_linux_virtual_machine.this
}
