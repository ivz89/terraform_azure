
resource "azurerm_key_vault" "localaccounts-kv" {
  name                        = "localaccounts-kv"
  location                    = azurerm_resource_group.tflabs.location
  resource_group_name         = azurerm_resource_group.tflabs.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true
  sku_name = "standard"
  enable_rbac_authorization = true
}

resource "random_password" "localadmin" {
  length  = 20
  special = true
}

resource "azurerm_key_vault_secret" "localadmin" {

  name         = "localadmin"
  key_vault_id = azurerm_key_vault.localaccounts-kv.id
  value        = random_password.localadmin.result

  lifecycle {
    ignore_changes = [
      value
    ]

  }
}


resource "azurerm_log_analytics_workspace" "LAWsentinel" {
  name                = "LAWsentinel"
  location            = azurerm_resource_group.sentinel.location
  resource_group_name = azurerm_resource_group.sentinel.name
}


resource "azurerm_network_security_rule" "tfnsgrule1" {
  name                        = "tfnsg-rule1"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "172.30.0.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.tflabs.name
  network_security_group_name = azurerm_network_security_group.tfnsg1.name
}

resource "azurerm_network_security_rule" "AllowAnyHTTPInbound" {
  name                        = "AllowAnyHTTPInbound"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.tflabs.name
  network_security_group_name = azurerm_network_security_group.tfnsg1.name
}

resource "azurerm_network_security_group" "tfnsg1" {
  name                = "tfnsg1"
  location            = azurerm_resource_group.tflabs.location
  resource_group_name = azurerm_resource_group.tflabs.name
}


resource "azurerm_network_interface_security_group_association" "nsgass1" {
  for_each                  = local.ComponentServersWindows
  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.tfnsg1.id
}

resource "azurerm_log_analytics_solution" "solution_sentinel" {
  solution_name         = "SecurityInsights"
  location              = azurerm_resource_group.sentinel.location
  resource_group_name   = azurerm_resource_group.sentinel.name
  workspace_resource_id = azurerm_log_analytics_workspace.LAWsentinel.id
  workspace_name        = azurerm_log_analytics_workspace.LAWsentinel.name
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}

data "azurerm_key_vault_secret" "TF-App-Secret" {
  name         = "TF-App-Secret"
  key_vault_id = azurerm_key_vault.localaccounts-kv.id
}



resource "azurerm_key_vault_certificate" "vpncert" {
  name         = "LABROOT"
  key_vault_id = azurerm_key_vault.localaccounts-kv.id
  tags         = {}

  certificate {
    contents = var.certificate_base64
    password = var.cert_pass
  }

}