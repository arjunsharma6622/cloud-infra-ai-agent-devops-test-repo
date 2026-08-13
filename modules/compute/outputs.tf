output "vm_ids" {
  value       = azurerm_linux_virtual_machine.vm[*].id
  description = "The IDs of the deployed virtual machines."
}