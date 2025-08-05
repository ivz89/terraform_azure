module "network_core" {
  source              = "./modules/network_core"
  vnet_name           = "iv-dev-vnet"
  vnet_cidr           = "10.0.0.0/16"
  subnet_names        = ["VMsubnet", "GatewaySubnet"]
  location            = var.location
  resource_group_name = "iv-dev-rg-Network"
  prefix              = "iv-dev"
}

module "security" {
  source              = "./modules/security"
  prefix              = "iv-dev"
  location            = var.location
  resource_group_name = "iv-dev-rg-Security"
  tenant_id           = var.tenant_id
  certificate_base64  = var.certificate_base64
  cert_pass           = var.cert_pass
}

module "virtual_network_gateway" {
  source              = "./modules/virtual_network_gateway"
  prefix              = "iv-dev"
  location            = var.location
  resource_group_name = "iv-dev-rg-Network"
  gateway_subnet_id   = module.network_core.subnet_ids["GatewaySubnet"]
  certificate_base64  = var.certificate_base64
  cert_name           = "VPNCERT"
}

module "storage" {
  source              = "./modules/storage"  # or whatever path you use
  prefix              = "iv-dev"
  resource_group_name = "iv-dev-rg-Storage"
  location            = var.location
}

module "compute" {
  source                  = "./modules/compute"
  prefix                  = "iv-dev"
  resource_group_name_VMs = "iv-dev-rg-VM"
  resource_group_name     = "iv-dev-rg-Network"
  location                = var.location
  network_nsgs            = module.network_core.nsg_ids
  network_subnets         = module.network_core.subnet_ids
  admin_username          = var.windows_local_admin_user
  admin_password          = var.windows_local_admin_password
  email                   = var.email
  storage_account_uri     = module.storage.storage_account_primary_blob_endpoint

  vm_map = merge(
    local.ComponentServersWindows,
    local.ComponentServersLinux
  )
}