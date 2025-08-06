# Terraform Project Structure

This repository contains Terraform configurations for provisioning and managing Azure infrastructure using modular design. Below is an overview of the project layout and purpose of each folder.

---

## Root Directory

- `.github/workflows/`  
  Contains GitHub Actions workflows for CI/CD automation such as Terraform plan and apply pipelines.

- `.terraform/`  
  Directory where Terraform stores modules, provider plugins, and related state information.  

- `modules/`  
  Contains custom Terraform modules developed to organize infrastructure components by logical function.

---

## Modules

Each module encapsulates a specific area of infrastructure:

- `compute/`  
  Resources related to virtual machines, VM scale sets, or other compute services.

- `network_core/`  
  Core networking components such as virtual networks, subnets, and network security groups.

- `security/`  
  Security-related infrastructure including Azure Key Vaults, certificates, firewall rules, and policies.

- `storage/`  
  Storage accounts, blobs, queues, and other storage-related resources.

- `virtual_network_gateway/`  
  Azure Virtual Network Gateway resources to manage VPN Gateway, including Point-to-Site (P2S) VPN configurations.
