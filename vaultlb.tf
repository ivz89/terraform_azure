/*
resource "azurerm_lb" "VaultLB" {
  name                = "VaultLB"
  location            = azurerm_resource_group.cyberarkresourcegroup.location
  resource_group_name = azurerm_resource_group.cyberarkresourcegroup.name

  sku = "Standard"

  frontend_ip_configuration {
    name                          = "VaultILB"
    private_ip_address            = "192.168.10.20"
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
    subnet_id                     = data.azurerm_subnet.VaultServices.id
    zones = [
      "1",
      "2",
      "3",
    ]
  }

  tags = local.tags
}

resource "azurerm_lb_backend_address_pool" "VaultBE" {
  loadbalancer_id = azurerm_lb.VaultLB.id
  name            = "VaultBE"
}

resource "azurerm_lb_probe" "VaultHP" {
  loadbalancer_id     = azurerm_lb.VaultLB.id
  name                = "VaultHP"
  port                = 1858
  protocol            = "Tcp"
  interval_in_seconds = 5
  number_of_probes    = 1
}

resource "azurerm_lb_rule" "VaultService" {
  loadbalancer_id                = azurerm_lb.VaultLB.id
  name                           = "VaultService"
  protocol                       = "Tcp"
  frontend_port                  = 1858
  backend_port                   = 1858
  frontend_ip_configuration_name = "VaultILB"
  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.VaultBE.id
  ]
  disable_outbound_snat   = true
  enable_tcp_reset        = false
  idle_timeout_in_minutes = 4
  probe_id                = azurerm_lb_probe.VaultHP.id
  load_distribution       = "SourceIPProtocol"
}

resource "azurerm_network_interface_backend_address_pool_association" "labVault03" {
  network_interface_id    = azurerm_network_interface.nic["labVault03"].id
  ip_configuration_name   = "ipconfig-labVault03"
  backend_address_pool_id = azurerm_lb_backend_address_pool.VaultBE.id
}

resource "azurerm_network_interface_backend_address_pool_association" "labVault04" {
  network_interface_id    = azurerm_network_interface.nic["labVault04"].id
  ip_configuration_name   = "ipconfig-labVault04"
  backend_address_pool_id = azurerm_lb_backend_address_pool.VaultBE.id
}

*/