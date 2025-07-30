variable "azure_region" {
  type    = string
  default = "Norway East"

}

variable "windows_local_admin_user" {

  type    = string
  default = "oatadmin"

}

variable "windows_local_admin_password" {
  type        = string
  sensitive   = true
}

variable "certificate_base64" {
  description = "Base64-encoded content of the certificate"
  type        = string
  sensitive   = true
}

variable "managed_identity_type" {
  default = {
    labVault01 = "SystemAssigned"
  }
}

variable "managed_identity_ids" {
  default = [
    "empty"
  ]

}

variable "tenant_id" {
  type    = string
  sensitive   = true
}

variable "client_id" {
  type    = string
  sensitive   = true
}
variable "client_secret" {
  type    = string
  sensitive   = true
}


locals {

  tags = {
    environment = "TF Lab"
    owner       = "OCD"
    department  = "Cloud"
    location    = "Norway East"
    user        = "Ivan"
  }

  os = {
    #Publisher = Publisher ID
    #Offer = Product ID
    #Sku = Plan ID
    wserver = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter"
    }
    w10 = {
      publisher = "MicrosoftWindowsDesktop"
      offer     = "Windows-10"
      sku       = "win10-21h2-pro-g2"
    }
    mssql = {
      publisher = "microsoftsqlserver"
      offer     = "sql2022-ws2022"
      sku       = "sqldev-gen2"
    }
    centos = {
      publisher = "eurolinuxspzoo1620639373013"
      offer     = "centos-8-5-free"
      sku       = "centos-8-5-free"
    }
    ubuntu = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts-gen2"
    }
    kali = {
      publisher = "kali-linux"
      offer     = "kali"
      sku       = "kali-2023-2"
    }
  }
}

