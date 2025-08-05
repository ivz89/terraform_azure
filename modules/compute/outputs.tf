output "vm_ids" {
  value = {
    windows = { for k, v in azurerm_windows_virtual_machine.winvm : k => v.id }
    linux   = { for k, v in azurerm_linux_virtual_machine.linuxvm : k => v.id }
  }
}
