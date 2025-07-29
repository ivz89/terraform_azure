resource "azurerm_resource_group" "tflabs" {
  name     = "iv-rg-tflabs"
  location = var.azure_region

  tags = local.tags
}

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

/*
resource "azurerm_marketplace_agreement" "kali" {
  publisher = local.os.kali.publisher
  offer     = local.os.kali.offer
  plan      = "byol"
}
*/