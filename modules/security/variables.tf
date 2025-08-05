variable "prefix" {
  type        = string
  description = "Resource naming prefix"
}

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name"
  default     = "iv-rg-dev-Security"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "norwayeast"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID"
  sensitive   = true
}

variable "certificate_base64" {
  type        = string
  description = "Base64 encoding of certificate"
  sensitive   = true
}

variable "cert_pass" {
  type        = string
  description = "Password for certificate"
  sensitive   = true
}