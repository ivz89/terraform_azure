resource "azurerm_resource_group" "Security" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_string" "storage_suffix" {
  length  = 8
  lower   = true
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_storage_account" "simple" {
  name                     = "oatorg${random_string.storage_suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"
}
