variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR block for the VNet"
  type        = string
}

variable "subnet_names" {
  description = "List of subnet names"
  type        = list(string)
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "norwayeast"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "iv-dev-rg-Network"
}

variable "prefix" {
  description = "Naming prefix for NSGs and other resources"
  type        = string
}
