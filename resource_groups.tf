
resource "azurerm_resource_group" "sentinel" {
  name     = "iv-rg-Sentinel"
  location = var.azure_region

  tags = local.tags
}

resource "azurerm_resource_group" "tflabs" {
  name     = "iv-rg-tflabs"
  location = var.azure_region

  tags = local.tags
}