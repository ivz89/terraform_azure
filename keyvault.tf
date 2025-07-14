/*
resource "azurerm_key_vault" "localaccounts-kv" {
  name                        = "localaccounts"
  location                    = azurerm_resource_group.tflabs.location
  resource_group_name         = azurerm_resource_group.tflabs.name
  enabled_for_disk_encryption = true
  tenant_id                   = "f995c4e8-3b73-4ede-9146-2234a3c136d7"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"

  access_policy {
    tenant_id = "f995c4e8-3b73-4ede-9146-2234a3c136d7"
    object_id = "6ddcb7d0-51de-46be-96d9-e5fa389ec37c"

    key_permissions = [
      "Encrypt", "Decrypt",
      "WrapKey", "UnwrapKey",
      "Sign", "Verify",
      "Get", "List",
      "Create", "Update",
      "Import", "Delete",
      "Recover", "Backup",
      "Restore", "Purge"
    ]

    secret_permissions = [
      "Get", "List",
      "Set", "Delete",
      "Recover", "Backup",
      "Restore", "Purge"
    ]

    certificate_permissions = [
      "ManageContacts", "GetIssuers",
      "ListIssuers", "SetIssuers",
      "DeleteIssuers", "ManageIssuers",
      "Get", "List",
      "Create", "Import",
      "Update", "Delete",
      "Recover", "Backup",
      "Restore", "Purge"

    ]

    storage_permissions = [
      "Get", "List"
    ]
  }
}

resource "random_password" "localadmin" {
  length  = 20
  special = true
}

resource "azurerm_key_vault_secret" "localadmin" {

  name         = "localadmin"
  key_vault_id = azurerm_key_vault.localaccounts-kv.id
  value        = random_password.localadmin.result

  lifecycle {
    ignore_changes = [
      value
    ]

  }
}
*/