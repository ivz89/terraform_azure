output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  value = { for name, subnet in azurerm_subnet.subnets : name => subnet.id }
}

output "nsg_ids" {
  value = { for name, nsg in azurerm_network_security_group.nsgs : name => nsg.id }
}
