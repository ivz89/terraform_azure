resource "azurerm_log_analytics_solution" "solution_sentinel" {
  solution_name         = "SecurityInsights"
  location              = azurerm_resource_group.sentinel.location
  resource_group_name   = azurerm_resource_group.sentinel.name
  workspace_resource_id = azurerm_log_analytics_workspace.LAWsentinel.id
  workspace_name        = azurerm_log_analytics_workspace.LAWsentinel.name
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}