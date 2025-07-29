locals {
  ComponentServersWindows = {

    "DC-01" = { ip = "10.1.0.10", vmsize = "Standard_D2_v4", os = local.os.wserver, subnet = azurerm_subnet.tfsubnet1.id,  identity = "SystemAssigned" }
    #"WinWrk-01"   = {ip = "10.1.0.21", vmsize = "Standard_D2_v4", os = local.os.w10, subnet = azurerm_subnet.tfsubnet1.id}
    #"Attckr-02" = {ip = "10.1.0.22", vmsize = "Standard_D2_v4", os = local.os.w10, subnet = azurerm_subnet.tfsubnet1.id}
    "MSSQL-01" = { ip = "10.1.0.23", vmsize = "Standard_D2_v4", os = local.os.mssql, subnet = azurerm_subnet.tfsubnet1.id,  identity = "SystemAssigned" }
    #"labVault04" = { ip = "192.168.10.22", vmsize = "Standard_D2_v4", subnet = data.azurerm_subnet.VaultServices.id, identity = "SystemAssigned", nic = azurerm_network_interface.niclabvault04, backend = true }


  }

  depends_on = [
    azurerm_resource_group.tflabs
  ]
}

locals {
  ComponentServersLinux = {

    "LogCollector-01" = { ip = "10.1.0.31", vmsize = "Standard_D2_v4", os = local.os.centos, subnet = azurerm_subnet.tfsubnet1.id,  identity = "SystemAssigned" }
    #"Attckr-01"  = { ip = "10.1.0.32", vmsize = "Standard_F4s_v2", os = local.os.kali, subnet = azurerm_subnet.tfsubnet1.id }
    #"Nix-Srv3"  = { ip = "10.1.0.33", vmsize = "Standard_D2_v4", os = "Ubuntu", subnet = azurerm_subnet.tfsubnet1.id }
    #"LogCollector-02" = { ip = "10.1.0.34", vmsize = "Standard_D2_v4", os = local.os.centos, subnet = azurerm_subnet.tfsubnet1.id,  identity = "SystemAssigned" }
    #"labHTGW01" = { ip = "192.168.30.20", vmsize = "Standard_D2_v4", os = "CentOS", subnet = data.azurerm_subnet.PSM.id }
    #"labHTGW02" = { ip = "192.168.30.21", vmsize = "Standard_D2_v4", os = "RHEL", subnet = data.azurerm_subnet.PSM.id }
    #"labPSMP01" = { ip = "192.168.30.30", vmsize = "Standard_D2_v4", os = "RHEL", subnet = data.azurerm_subnet.PSM.id }
    #"labPSMP02" = { ip = "192.168.30.31", vmsize = "Standard_D2_v4", os = "RHEL", subnet = data.azurerm_subnet.PSM.id }
  }
}

resource "azurerm_network_interface" "nic" {
  for_each            = local.ComponentServersWindows
  name                = "nic-${each.key}"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.tflabs.name

  ip_configuration {

    name                          = "ipconfig-${each.key}"
    subnet_id                     = each.value.subnet
    private_ip_address_allocation = "Static"
    private_ip_address            = each.value.ip
  }

  #tags = local.tags
 
}

resource "azurerm_windows_virtual_machine" "vm" {
  for_each              = local.ComponentServersWindows
  name                  = each.key
  resource_group_name   = azurerm_resource_group.tflabs.name
  location              = var.azure_region
  size                  = each.value.vmsize
  admin_username        = var.windows_local_admin_user
  admin_password        = azurerm_key_vault_secret.localadmin.value
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    name                 = "mdisk-${each.key}-os"
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
  timezone                 = "W. Europe Standard Time"

  boot_diagnostics {
    storage_account_uri = "https://ivtfstate.blob.core.windows.net/"
  }
  /*
  dynamic "identity" {
    for_each = each.value.identity != null ? [1] : []

    content {
      type         = each.value.identity
      identity_ids = each.value.identity == "UserAssigned" || each.value.identity == "SystemAssigned, UserAssigned" ? var.managed_identity_ids : []
    }
  }
*/
  lifecycle {
    ignore_changes = [
      identity,
    ]
  }

  #tags = local.tags
}


resource "azurerm_network_interface" "niclinux" {
  for_each            = local.ComponentServersLinux
  name                = "nic-${each.key}-1"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.tflabs.name

  ip_configuration {

    name                          = "ipconfig-${each.key}"
    subnet_id                     = each.value.subnet
    private_ip_address_allocation = "Static"
    private_ip_address            = each.value.ip

  }

  #tags = local.tags
}

resource "azurerm_linux_virtual_machine" "vmlinux" {
  for_each            = local.ComponentServersLinux
  name                = each.key
  resource_group_name = azurerm_resource_group.tflabs.name
  location            = var.azure_region
  size                = each.value.vmsize
  admin_username      = var.windows_local_admin_user
  admin_password      = azurerm_key_vault_secret.localadmin.value
  network_interface_ids = [
    azurerm_network_interface.niclinux[each.key].id
  ]
  disable_password_authentication = false

  os_disk {
    name                 = "mdisk-${each.key}-os"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = each.key == "labPTA02" ? "500" : "64"
  }

  source_image_reference {
    publisher = each.value.os.publisher
    offer     = each.value.os.offer
    sku       = each.value.os.sku
    version   = "Latest"
  }

  plan {
    name      = each.value.os.sku
    product   = each.value.os.offer
    publisher = each.value.os.publisher
  }

  provision_vm_agent = true

  boot_diagnostics {

    storage_account_uri = "https://ivtfstate.blob.core.windows.net/"

  }
  lifecycle {
    ignore_changes = [
      identity, plan, source_image_reference
    ]
  }
  #tags = local.tags
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "WindowsServerAutoShutdown" {
  for_each           = local.ComponentServersWindows
  virtual_machine_id = azurerm_windows_virtual_machine.vm[each.key].id
  location           = azurerm_resource_group.tflabs.location
  enabled            = true

  daily_recurrence_time = "1900"
  timezone              = "W. Europe Standard Time"

  notification_settings {
    enabled         = true
    time_in_minutes = "30"
    email           = "ivan.vorobiev@orangecyberdefense.com"
    #webhook_url     = "https://sample-webhook-url.example.com"
  }

  #tags = local.tags
}


resource "azurerm_dev_test_global_vm_shutdown_schedule" "LinuxServerAutoShutdown" {
  for_each           = local.ComponentServersLinux
  virtual_machine_id = azurerm_linux_virtual_machine.vmlinux[each.key].id
  location           = azurerm_resource_group.tflabs.location
  enabled            = true

  daily_recurrence_time = "1900"
  timezone              = "W. Europe Standard Time"

  notification_settings {
    enabled         = true
    time_in_minutes = "30"
    email           = "ivan.vorobiev@orangecyberdefense.com"
    #webhook_url     = "https://sample-webhook-url.example.com"
  }

  #tags = local.tags
}
