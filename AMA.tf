/*

resource "azurerm_monitor_data_collection_rule" "DCRsentinel" {
  name                = "iv-dcr-Sentinel"
  resource_group_name = azurerm_resource_group.sentinel.name
  location            = azurerm_resource_group.sentinel.location
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.DCEsentinel.id

  destinations {
    log_analytics {
      workspace_resource_id = azurerm_log_analytics_workspace.LAWsentinel.id
      name = "LAWsentinel"
    }
  }
  data_flow {
    streams      = ["Microsoft-Syslog"]
    destinations = ["LAWsentinel"]
  }
}




resource "azurerm_monitor_data_collection_endpoint" "DCEsentinel" {
  name                = "iv-dce-Sentinel"
  resource_group_name = azurerm_resource_group.sentinel.name
  location            = azurerm_resource_group.sentinel.location
}

# associate to a Data Collection Rule
resource "azurerm_monitor_data_collection_rule_association" "winDCRa" {
  for_each                = local.ComponentServersWindows
  name                    = "DCRa"
  target_resource_id      = azurerm_windows_virtual_machine.vm[each.key].id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.DCRsentinel.id
}

# associate to a Data Collection Endpoint
resource "azurerm_monitor_data_collection_rule_association" "nixDCRa" {
  for_each                    = local.ComponentServersLinux
  target_resource_id          = azurerm_linux_virtual_machine.vmlinux[each.key].id
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.DCEsentinel.id
}
*/