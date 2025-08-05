variable "azure_region" {
  type    = string
  default = "Norway East"

}

variable "prefix" {
  type    = string
  default = "IV"  # Or set this when calling the module
}



variable "resource_group_name_Network" {
  type = string
  default = "Network"
}

variable "location" {
  type = string
  default = "norwayeast"
}

variable "vnet_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "network_address_space" {
  type = list(string)
  default = ["10.1.0.0/20","10.2.0.0/20"]
}

variable "subnet_prefixes" {
  type = list(string)
  default = ["10.1.0.0/20", "10.2.2.0/24"]
}

variable "subnet_names" {
  type = list(string)
  default = ["Tfsubnet1", "GatewaySubnet"]
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

variable "email" {
  type    = string
  sensitive   = true
}

variable "upn1" {
  type    = string
  sensitive   = true
}

variable "cert_pass" {
  type    = string
  sensitive   = true
}

locals {

  tags = {
    environment = "TF Lab"
    owner       = "OAT"
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
    oracle = {
      publisher = "oracle"
      offer     = "oracle-linux"
      sku       = "ol94-lvm"
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

