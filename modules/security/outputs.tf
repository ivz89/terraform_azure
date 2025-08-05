output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "law_id" {
  value = azurerm_log_analytics_workspace.law.id
}

output "localadmin_secret_name" {
  value = azurerm_key_vault_secret.localadmin.name
}