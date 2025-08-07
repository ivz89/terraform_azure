## To be migrated
resource "azurerm_resource_group" "sentinel" {
  name     = "iv-rg-Sentinel"
  location = var.azure_region

  tags = local.tags
}


resource "azurerm_resource_group" "b2b_automation_test" {
  name     = "rg-automation-test"
  location = var.azure_region

  tags = local.tags
} 