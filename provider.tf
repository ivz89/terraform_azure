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
    #access_key           = "sp=racwdyti&st=2025-02-09T18:45:51Z&se=2025-02-10T02:45:51Z&spr=https&sv=2022-11-02&sr=b&sig=ugXvdGJC9q7D6MXv59qd6wiQRXr8bJ9CRjghn409eZ8%3D"
  }  
}



provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
  }

  use_oidc        = true   
}

provider "azuread" {
}
