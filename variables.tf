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

variable "sub_id" {
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



