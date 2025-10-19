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

variable "ssh_public_keys" {
  description = "List of SSH public keys for admin user"
  type        = list(string)
  default     = [
  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBv9xb3Ew9DdPaEytkqtMC4X6h7kKnOJuGtPdPUPUNcn4IVwUCYdmAHgKrdUW87sY+xt3nPgdxTsaBCDP5O8p0ZJrZa95L5t/by1EebDXci93tFMw6SYKz5FtsQ5EvXuBIh9XBaJLUipCIBoOs3vLnZjKLnOAH/+ZqkQizukWd5qfJbvptqsxbisGoRlaVtjnfFmDR028Y9O6CCUEPrZdBUUP2RHiQ6A5f7eaG+hAUPlqE/zjUXX2Qr3cIBjLQD5NafuAN7Hr/Nc4Zs+Ax9VB/h3dgLhGtjQri0p1iWgNFQsJQHyWBipFhOemC2diH/wUOBNNhL4aHtaOU1ku0143tR4gMR8Aq23TFOyn/QMTU/qFQITaCmU8MtIiZt+yO9BesRqeeCOGTwG/ClbhJ2oQaA8xuZUOx5tDxUX7oy3BwW0H3hCmnVJPMIl/KiL88Jv8P2v2Y9plBeHkzMvy3Eoxd6aLC90EU3875PAjcGs+3ryzsN2B+Nb/qUce5wnmGc3Cf8iMjHI4kBlpbDHePIgVQyb3kaozJcV/YWl7TBJhXKRVU+HKnfcpxJs1aKaSDfkxv4Jk1VUU7hERsFVJ68+ZomtZZylx3fcix5IjO98FwpqMoZgtF/b5aqablQb/S06+p6pWnoA3Y7wLXrujChTn5eIZqypAf8uGPbJoKyr3WhQ==",
  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDoyPQU1L3q2SUIco9ADQE+VGRz3BcMpBhlVptcV/pJCr2Ue2pOJMX0X55Ahdttg2x2Wxq6NrsZsZnf9Py8v6F2BtJHoVnowP3m9OfGLpzsG1V+82DOc4NzD2GXfB/dwzJxrNuXo0ae9r3NJj6HVcz7s0nqi+diSDrKuOGXzIFkpgf/XNxUqHlH3h7eWr+Udm3pydigpgCoE3qDNBWelM4/hckz38qdxtW1dMLmr8ZSyosyZ47kJ54R9+SyH5iXvEw+as2o8mqFF7ioJL9rQ6euWr/X9R2nwQTqmCpJITOakyFc2IvJ/e+bS4EffE4fSzWiZpiOa54QaKx+o74H2kw9"
]
}