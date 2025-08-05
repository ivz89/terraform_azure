resource "azurerm_resource_group" "Network" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_resource_group.Network]
}

resource "azurerm_subnet" "subnets" {
  for_each = toset(var.subnet_names)

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [cidrsubnet(var.vnet_cidr, 8, index(var.subnet_names, each.key))]
  
  depends_on = [azurerm_resource_group.Network, azurerm_virtual_network.this]
}

resource "azurerm_network_security_group" "nsgs" {
  for_each = toset(var.subnet_names)

  name                = "${var.prefix}-${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  
  depends_on = [azurerm_resource_group.Network]
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each = {
    for k, v in azurerm_subnet.subnets : k => v
    if v.name != "GatewaySubnet"
  }

  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.nsgs[each.key].id
  
  depends_on = [azurerm_resource_group.Network, azurerm_subnet.subnets, azurerm_network_security_group.nsgs]
}
