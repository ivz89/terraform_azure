variable "prefix" {
  type        = string
  description = "Prefix for all naming"
}

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "public_ip_suffix" {
  type        = string
  default     = "vng-pip"
  description = "Suffix for public IP name"
}

variable "gateway_subnet_id" {
  type        = string
  description = "ID of the GatewaySubnet"
}

variable "certificate_base64" {
  type        = string
  description = "Base64 of root certificate for VPN client"
  sensitive   = true
}

variable "cert_name" {
  type        = string
  default     = "vpncert"
  description = "Certificate name"
}
