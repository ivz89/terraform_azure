resource "azurerm_resource_group" "VMs" {
  name     = var.resource_group_name_VMs
  location = var.location
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.vm_map
  name                = "nic-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name_VMs

  ip_configuration {
    name                          = "ipconfig-${each.key}"
    subnet_id                     = each.value.subnet
    private_ip_address_allocation = "Static"
    private_ip_address            = each.value.ip
  }

  depends_on = [azurerm_resource_group.VMs]
}

resource "azurerm_windows_virtual_machine" "winvm" {
  for_each = {
    for k, v in var.vm_map : k => v
    if can(regex("windows|microsoft", lower(v.os.publisher)))
  }
  name                  = each.key
  resource_group_name   = var.resource_group_name_VMs
  location              = var.location
  size                  = each.value.vmsize
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    name                 = "osdisk-${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = each.value.os.publisher
    offer     = each.value.os.offer
    sku       = each.value.os.sku
    version   = "Latest"
  }

  provision_vm_agent       = true
  enable_automatic_updates = true

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  lifecycle {
    ignore_changes = [identity]
  }

  depends_on = [azurerm_resource_group.VMs]
}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  for_each = {
    for k, v in var.vm_map : k => v
    if can(regex("linux|canonical|oracle", lower(v.os.publisher)))
  }
  name                  = each.key
  resource_group_name   = var.resource_group_name_VMs
  location              = var.location
  size                  = each.value.vmsize
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    name                 = "osdisk-${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = each.value.os.publisher
    offer     = each.value.os.offer
    sku       = each.value.os.sku
    version   = "Latest"
  }

  provision_vm_agent = true

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  lifecycle {
    ignore_changes = [identity]
  }

  depends_on = [azurerm_resource_group.VMs]
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "vm_shutdown" {
  for_each = var.vm_map

  virtual_machine_id = try(
    azurerm_windows_virtual_machine.winvm[each.key].id,
    azurerm_linux_virtual_machine.linuxvm[each.key].id
  )

  location = var.location
  enabled  = true
  daily_recurrence_time = "1900"
  timezone              = "W. Europe Standard Time"

  notification_settings {
    enabled         = true
    time_in_minutes = 30
    email           = var.email
  }

  depends_on = [
    azurerm_linux_virtual_machine.linuxvm,
    azurerm_windows_virtual_machine.winvm
  ]
}

resource "azurerm_network_security_rule" "allow_rdp" {
  for_each = {
  for k, v in var.network_nsgs : k => v if contains(["VMSubnet"], k)
}

  name                        = "allow_VPN_RDP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "172.30.0.0/24"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = each.value.name
  
}