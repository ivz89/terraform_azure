

resource "azurerm_public_ip" "IV-VNG-Pub-IP" {
  name                = "IV-VNG-PubIP"
  location            = azurerm_resource_group.tflabs.location
  resource_group_name = azurerm_resource_group.tflabs.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_virtual_network_gateway" "IV-VNG" {
  name                = "IV-VNG"
  location            = azurerm_resource_group.tflabs.location
  resource_group_name = azurerm_resource_group.tflabs.name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = false
  sku                 = "Basic"

  ip_configuration {
    name                          = "vngwipconfig"
    public_ip_address_id          = azurerm_public_ip.IV-VNG-Pub-IP.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.GatewaySubnet.id
  }
  vpn_client_configuration {
    address_space = ["172.30.0.0/24"]
    root_certificate {
      name = "LABROOT"
      public_cert_data = azurerm_key_vault_certificate.vpncert.certificate_data_base64
    }
  }
  depends_on = [
    azurerm_key_vault_certificate.vpncert
  ]
}

resource "azurerm_virtual_network" "tfvnet1" {
  name                = "tfvnet1"
  location            = azurerm_resource_group.tflabs.location
  resource_group_name = azurerm_resource_group.tflabs.name
  address_space       = ["10.1.0.0/20","10.2.0.0/20"]

}

resource "azurerm_virtual_network_dns_servers" "tfvnet1dns" {
  virtual_network_id = azurerm_virtual_network.tfvnet1.id
  dns_servers        = ["10.1.0.10", "8.8.8.8"]
}

resource "azurerm_subnet" "tfsubnet1" {
  name                 = "Tfsubnet1"
  resource_group_name  = azurerm_resource_group.tflabs.name
  virtual_network_name = azurerm_virtual_network.tfvnet1.name
  address_prefixes     = ["10.1.0.0/20"]

  depends_on = [
    azurerm_resource_group.tflabs, azurerm_virtual_network.tfvnet1
  ]
}
resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.tflabs.name
  virtual_network_name = azurerm_virtual_network.tfvnet1.name
  address_prefixes     = ["10.2.2.0/24"]

  depends_on = [
    azurerm_resource_group.tflabs, azurerm_virtual_network.tfvnet1
  ]
}
