resource "azurerm_resource_group" "Security" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_key_vault" "kv" {
  name                        = "${var.prefix}-kv"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true
  sku_name                    = "standard"
  enable_rbac_authorization   = true
  
  depends_on = [azurerm_resource_group.Security]
}

resource "random_password" "localadmin" {
  length  = 20
  special = true
}

resource "azurerm_key_vault_secret" "localadmin" {
  name         = "${var.prefix}-localadmin"
  key_vault_id = azurerm_key_vault.kv.id
  value        = random_password.localadmin.result

  lifecycle {
    ignore_changes = [value]
  }
  
  depends_on = [azurerm_key_vault.kv]
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.prefix}-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  
  depends_on = [azurerm_resource_group.Security]
}

resource "azurerm_log_analytics_solution" "sentinel" {
  solution_name         = "SecurityInsights"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
  
  depends_on = [azurerm_log_analytics_workspace.law]
}

/*
resource "azurerm_key_vault_certificate" "vpncert" {
  name         = "${var.prefix}-vpncert"
  key_vault_id = azurerm_key_vault.kv.id
  tags         = {}

  certificate {
    contents = var.certificate_base64

  }
  
  depends_on = [azurerm_key_vault.kv]
}

*/