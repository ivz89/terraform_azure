
resource "azuread_user" "privtest" {
  user_principal_name   = var.upn1
  display_name          = "privtest"
  show_in_address_list  = false
}

resource "azuread_group" "msiem" {
  display_name = "MSIEM"
  security_enabled = true
}
/*
resource "azuread_group_member" "msiem" {
  group_object_id  = azuread_group.msiem.id
  member_object_id = azuread_user.privtest.id
}

locals {
  msiem_roles = {
    "monitoring_contributor"                = "Monitoring Contributor"
    "log_analytics_workspace_contributor"   = "Log Analytics Contributor"
  }
}

data "azurerm_role_definition" "each" {
  for_each = local.msiem_roles
  name     = each.value
}

resource "azurerm_role_assignment" "msiem" {
  for_each           = local.msiem_roles
  scope              = azurerm_resource_group.sentinel.id
  role_definition_id = data.azurerm_role_definition.each[each.key].id
  principal_id       = azuread_group.msiem.id

  lifecycle {
    ignore_changes = [
      role_definition_id
    ]
  }
  


}



*/