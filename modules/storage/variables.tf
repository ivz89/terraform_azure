variable "prefix" {
  description = "Prefix to use for naming the storage account"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name"
  default     = "iv-rg-dev-Storage"
}

variable "location" {
  description = "Azure region to deploy the storage account"
  type        = string
}