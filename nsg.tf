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


/*

resource "azurerm_network_security_group" "nsg-vault-in" {
  name                = "nsg-vault-in"
  location            = azurerm_resource_group.tflabs.location
  resource_group_name = azurerm_resource_group.tflabs.name

  security_rule {
    name                       = "vault-in"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["1858", "3389"]
    source_address_prefixes    = ["172.30.0.0/24", "10.0.0.0/8", "192.168.20.0/24", "192.168.30.0/24", "192.168.40.0/24", "192.168.10.0/24"]
    destination_address_prefix = "192.168.10.0/24"
  }

  tags = local.tags
}

resource "azurerm_network_interface_security_group_association" "nsg-ass-vault01" {
  network_interface_id      = azurerm_network_interface.nic["labVault01"].id
  network_security_group_id = azurerm_network_security_group.nsg-vault-in.id
}

resource "azurerm_network_interface_security_group_association" "nsg-ass-vault03" {
  network_interface_id      = azurerm_network_interface.nic["labVault03"].id
  network_security_group_id = azurerm_network_security_group.nsg-vault-in.id
}

resource "azurerm_network_interface_security_group_association" "nsg-ass-vault04" {
  network_interface_id      = azurerm_network_interface.nic["labVault04"].id
  network_security_group_id = azurerm_network_security_group.nsg-vault-in.id
}

*/