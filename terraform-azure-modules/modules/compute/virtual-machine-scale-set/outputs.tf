output "id" {
  description = "VMSS resource ID."
  value       = azurerm_linux_virtual_machine_scale_set.this.id
}

output "name" {
  description = "VMSS name."
  value       = azurerm_linux_virtual_machine_scale_set.this.name
}

output "virtual_machine_scale_set" {
  description = "VMSS resource object."
  value       = azurerm_linux_virtual_machine_scale_set.this
}
