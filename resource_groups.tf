
resource "azurerm_resource_group" "sentinel" {
  name     = "iv-rg-Sentinel"
  location = var.azure_region

  tags = local.tags
}


resource "azurerm_resource_group" "github" {
  name     = "iv-rg-GithubTest" 
  location = var.azure_region

  tags = local.tags
}
