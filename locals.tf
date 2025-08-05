locals {
  ComponentServersWindows = {

    #"DC-01" = { ip = "10.0.0.10", vmsize = "Standard_D2_v4", os = local.os.wserver, subnet = module.network_core.subnet_ids["VMsubnet"],  identity = "SystemAssigned" }
    #"WinWrk-01"   = {ip = "10.0.0.21", vmsize = "Standard_D2_v4", os = local.os.w10, subnet = module.network_core.subnet_ids["VMsubnet"]}
    #"Attckr-02" = {ip = "10.0.0.22", vmsize = "Standard_D2_v4", os = local.os.w10, subnet = module.network_core.subnet_ids["VMsubnet"]}
    #"MSSQL-01" = { ip = "10.0.0.23", vmsize = "Standard_D2_v4", os = local.os.mssql, subnet = module.network_core.subnet_ids["VMsubnet"],  identity = "SystemAssigned" }

  }
}

locals {
  ComponentServersLinux = {
    "LogCollector-01" = { ip = "10.0.0.31", vmsize = "Standard_D2_v4", os = local.os.oracle, subnet = module.network_core.subnet_ids["VMsubnet"],  identity = "SystemAssigned" }
    #"Attckr-01"  = { ip = "10.0.0.32", vmsize = "Standard_F4s_v2", os = local.os.kali, subnet = module.network_core.subnet_ids["VMsubnet"] }
    #"Nix-Srv3"  = { ip = "10.0.0.33", vmsize = "Standard_D2_v4", os = "Ubuntu", subnet = module.network_core.subnet_ids["VMsubnet"] }
    #"LogCollector-02" = { ip = "10.0.0.34", vmsize = "Standard_D2_v4", os = local.os.centos, subnet = module.network_core.subnet_ids["VMsubnet"],  identity = "SystemAssigned" }
  }
}