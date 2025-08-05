resource "azurerm_public_ip" "pip" {
  name                = "${var.prefix}-${var.public_ip_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_virtual_network_gateway" "vng" {
  name                = "${var.prefix}-vng"
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = false
  sku                 = "Basic"

  ip_configuration {
    name                          = "vng-ipconfig"
    public_ip_address_id          = azurerm_public_ip.pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gateway_subnet_id
  }

  vpn_client_configuration {
    address_space = ["172.30.0.0/24"]

    root_certificate {
      name              = var.cert_name
      public_cert_data  = var.certificate_base64
    }
  }

  lifecycle {
    ignore_changes = [
      vpn_client_configuration
    ]
  }

  depends_on = [
    azurerm_public_ip.pip
  ]
}




