locals {
  ComponentServersWindows = {

    #"DC-01" = { ip = "10.0.0.10", vmsize = "Standard_D2_v4", os = local.os.wserver, subnet = module.network_core.subnet_ids["VMsubnet"],  identity = "SystemAssigned" }
    #"WinWrk-01"   = {ip = "10.0.0.21", vmsize = "Standard_D2_v4", os = local.os.w10, subnet = module.network_core.subnet_ids["VMsubnet"]}
    #"Attckr-02" = {ip = "10.0.0.22", vmsize = "Standard_D2_v4", os = local.os.w10, subnet = module.network_core.subnet_ids["VMsubnet"]}
    #"MSSQL-01" = { ip = "10.0.0.23", vmsize = "Standard_D2_v4", os = local.os.mssql, subnet = module.network_core.subnet_ids["VMsubnet"],  identity = "SystemAssigned" }

  }

  ComponentServersLinux = {
    "LogCollector-01" = { ip = "10.0.0.31", vmsize = "Standard_D2_v4", os = local.os.oracle, subnet = module.network_core.subnet_ids["VMsubnet"],  identity = "SystemAssigned" }
    #"Attckr-01"  = { ip = "10.0.0.32", vmsize = "Standard_F4s_v2", os = local.os.kali, subnet = module.network_core.subnet_ids["VMsubnet"] }
    #"Nix-Srv3"  = { ip = "10.0.0.33", vmsize = "Standard_D2_v4", os = "Ubuntu", subnet = module.network_core.subnet_ids["VMsubnet"] }
    #"LogCollector-02" = { ip = "10.0.0.34", vmsize = "Standard_D2_v4", os = local.os.centos, subnet = module.network_core.subnet_ids["VMsubnet"],  identity = "SystemAssigned" }
  }
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
      publisher     = "ntegralinc1586961136942"
      offer         = "ntg_oracle_8_7"
      sku           = "ntg_oracle_8_7"
      version       = "1.0.3"
      requires_plan = true
    }
    ubuntu = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts-gen2"
      version   = "Latest"
      requires_plan = false

    }
    kali = {
      publisher = "kali-linux"
      offer     = "kali"
      sku       = "kali-2023-2"
      version   = "Latest"
      requires_plan = false

    }
  }
}