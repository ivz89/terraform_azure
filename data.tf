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


resource "azurerm_key_vault_certificate" "vpncert" {
  name         = "LABROOT"
  key_vault_id = azurerm_key_vault.localaccounts-kv.id
  tags         = {}

  certificate {
    contents = var.certificate_base64
    password = var.cert_pass
  }

}

data "azuread_domains" "default" {
  only_initial = true
}

data "azurerm_key_vault_secret" "TF-App-Secret" {
  name         = "TF-App-Secret"
  key_vault_id = azurerm_key_vault.localaccounts-kv.id
}

/*
resource "azurerm_virtual_network_peering" "tfvnet1-to-vnet_shared" {
  name                      = "tfvnet1-to-vnet_shared"
  resource_group_name       = azurerm_resource_group.tflabs.name
  virtual_network_name      = azurerm_virtual_network.tfvnet1.name
  remote_virtual_network_id = "/subscriptions/1111111111111/resourceGroups/rg-vnet_shared/providers/Microsoft.Network/virtualNetworks/vnet_shared"
  use_remote_gateways       = true
}


data "azurerm_resource_group" "vnetresourcegroup" {
  name = "rg-vnet_shared"
}

data "azurerm_resource_group" "mgmtserverresourcegroup" {
  name = "rg-mgmt-server"
}

data "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  resource_group_name = "rg-vnet_shared"
}

data "azurerm_virtual_network" "vnet_cyberark" {
  name                = "vnet_cyberark"
  resource_group_name = "rg-cyberark"

  depends_on = [
    azurerm_resource_group.cyberarkresourcegroup
  ]
}

data "azurerm_subnet" "DomainServices" {
  name                 = "DomainServices"
  resource_group_name  = "rg-vnet_shared"
  virtual_network_name = data.azurerm_virtual_network.vnet_shared.name
}

data "azurerm_subnet" "PKIServices" {
  name                 = "PKIServices"
  resource_group_name  = "rg-vnet_shared"
  virtual_network_name = data.azurerm_virtual_network.vnet_shared.name
}

data "azurerm_subnet" "AzureADServices" {
  name                 = "AzureADServices"
  resource_group_name  = "rg-vnet_shared"
  virtual_network_name = data.azurerm_virtual_network.vnet_shared.name
}

data "azurerm_subnet" "VaultServices" {
  name                 = "VaultServices"
  resource_group_name  = azurerm_resource_group.cyberarkresourcegroup.name
  virtual_network_name = data.azurerm_virtual_network.vnet_cyberark.name
}

data "azurerm_subnet" "CPMPTA" {
  name                 = "CPMPTA"
  resource_group_name  = azurerm_resource_group.cyberarkresourcegroup.name
  virtual_network_name = data.azurerm_virtual_network.vnet_cyberark.name
}

data "azurerm_subnet" "PSM" {
  name                 = "PSM"
  resource_group_name  = azurerm_resource_group.cyberarkresourcegroup.name
  virtual_network_name = data.azurerm_virtual_network.vnet_cyberark.name

}

data "azurerm_subnet" "PVWA" {
  name                 = "PVWA"
  resource_group_name  = azurerm_resource_group.cyberarkresourcegroup.name
  virtual_network_name = data.azurerm_virtual_network.vnet_cyberark.name

}

data "azurerm_subnet" "VaultClusterServices" {
  name                 = "VaultClusterServices"
  resource_group_name  = azurerm_resource_group.cyberarkresourcegroup.name
  virtual_network_name = data.azurerm_virtual_network.vnet_cyberark.name

}

data "azurerm_subnet" "AzureClientNet" {
  name                 = "AzureClientNet"
  resource_group_name  = data.azurerm_resource_group.vnetresourcegroup.name
  virtual_network_name = data.azurerm_virtual_network.vnet_shared.name

}


*/
