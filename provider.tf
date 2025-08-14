terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=4.1.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "iv-rg-Sentinel"
    storage_account_name = "ivtfstate"
    container_name       = "lab"
    key                  = "terraform.tfstate"
    use_oidc = true
  }  
}



provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
  }
  //subscription_id = var.sub_id
  use_oidc        = true   
}

provider "azuread" {
  tenant_id   = var.tenant_id
  client_id   = var.client_id
  client_secret = var.client_secret
}
