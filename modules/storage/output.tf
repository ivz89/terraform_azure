output "storage_account_name" {
  value = azurerm_storage_account.simple.name
}

output "storage_account_primary_blob_endpoint" {
  value = azurerm_storage_account.simple.primary_blob_endpoint
}

output "storage_account_primary_access_key" {
  value     = azurerm_storage_account.simple.primary_access_key
  sensitive = true
}