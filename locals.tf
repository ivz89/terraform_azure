locals {
  ComponentServersWindows = {

    #"DC-01" = { vmsize = "Standard_D2_v4", os = local.os.wserver, identity = "SystemAssigned", ip_subnets = [{ name = "Primary", ip = "10.0.0.10", subnet = module.network_core.subnet_ids["VMsubnet"] }]}
    #"WinWrk-01"   = { vmsize = "Standard_D2_v4", os = local.os.w10, identity = "SystemAssigned", ip_subnets = [{ name = "Primary", ip = "10.0.0.21", subnet = module.network_core.subnet_ids["VMsubnet"] }]}
    #"Attckr-02" = { vmsize = "Standard_D2_v4", os = local.os.w10, identity = "SystemAssigned", ip_subnets = [{ name = "Primary", ip = "10.0.0.22", subnet = module.network_core.subnet_ids["VMsubnet"] }]}
    #"MSSQL-01" = { vmsize = "Standard_D2_v4", os = local.os.mssql, identity = "SystemAssigned", ip_subnets = [{ name = "Primary", ip = "10.0.0.23", subnet = module.network_core.subnet_ids["VMsubnet"] }]}

  }

  ComponentServersLinux = {
    "LogCollector-01" = { vmsize = "Standard_D2_v4", os = local.os.oracle,  identity = "SystemAssigned",ip_subnets = [{ name = "Primary", ip = "10.0.0.31", subnet = module.network_core.subnet_ids["VMsubnet"] }]}
    #"FortiGate-01" = { vmsize = "Standard_D2_v4", os = local.os.fortigate,  identity = "SystemAssigned", ip_subnets = [{ name = "External", ip = "10.0.2.4", subnet = module.network_core.subnet_ids["FortiGateExternal"] },{ name = "Internal", ip = "10.0.3.4", subnet = module.network_core.subnet_ids["FortiGateInternal"] }]}
    #"Attckr-01"  = { vmsize = "Standard_F4s_v2", os = local.os.kali,  identity = "SystemAssigned",ip_subnets = [{ name = "Primary", ip = "10.0.0.32", subnet = module.network_core.subnet_ids["VMsubnet"] }]}
    #"LogCollector-02" = { vmsize = "Standard_D2_v4", os = local.os.oracle,  identity = "SystemAssigned",ip_subnets = [{ name = "Primary", ip = "10.0.0.34", subnet = module.network_core.subnet_ids["VMsubnet"] }]}
  }
}
 
locals {
  nic_map = {
    for vm_name, vm in merge(local.ComponentServersWindows, local.ComponentServersLinux) :
    vm_name => [
      for nic in vm.ip_subnets : {
        nic_key  = "${vm_name}-${nic.name}"
        vm_name  = vm_name
        vmsize   = vm.vmsize
        os       = vm.os
        identity = vm.identity
        ip       = nic.ip
        subnet   = nic.subnet
      }
    ]
  }
}

locals {
  nic_map_flat = {
    for nic_obj in flatten([for v in local.nic_map : v]) :
      nic_obj.nic_key => nic_obj
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
      offer         = "ntg_oracle_8_6"
      sku           = "ntg_oracle_8_6"
      version       = "latest"
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
    fortigate = {
      publisher = "fortinet"
      offer     = "fortinet_fortigate-vm_v5"
      sku       = "fortinet_fg-vm_payg_2023"
      version   = "Latest"
      requires_plan = true

    }
  }
}
