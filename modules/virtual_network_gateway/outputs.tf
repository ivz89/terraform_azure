output "public_ip_id" {
  value = azurerm_public_ip.pip.id
}

output "vng_name" {
  value = azurerm_virtual_network_gateway.vng.name
}

output "vng_id" {
  value = azurerm_virtual_network_gateway.vng.id
}
