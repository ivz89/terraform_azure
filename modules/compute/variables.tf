variable "prefix" {}
variable "location" {}
variable "resource_group_name" {}
variable "resource_group_name_VMs" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "iv-dev-rg-VM"
}

variable "admin_username" {
  sensitive   = true
}

variable "admin_password" {
  sensitive   = true
}

variable "storage_account_uri" {
  sensitive   = true
}

variable "email" {
  sensitive   = true
}

variable "network_nsgs" {
  type = map(string)
}

variable "network_subnets" {
  type = map(string)
}

variable "ComponentServersLinux" {
  type = map(any)
}

variable "ComponentServersWindows" {
  type = map(any)
}

variable "nic_map_flat" {
  type = map(any)
}