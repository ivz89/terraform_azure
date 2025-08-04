# Azure Infrastructure with Terraform

This repository contains Terraform configurations to deploy Azure infrastructure using automated workflows via GitHub.


## Repository Structure

- **`provider.tf`**: Azure provider configuration.
- **`versions.tf`**: Terraform and provider version requirements.
- **`variables.tf`**: Input variable definitions.
- **`entraID.tf`**: Azure Active Directory resources.
- **`network.tf`**: Virtual networks and subnets.
- **`resource_groups.tf`**: Resource group definitions.
- **`security.tf`**: Network security and related resources.
- **`servers.tf`**: Virtual machine provisioning.
- **`.terraform.lock.hcl`**: Provider version locking.
- **`.gitignore`**: Git ignore rules for sensitive files.


## Deployment Workflow

This repository is designed to be deployed through GitHub workflows that automatically apply Terraform changes on push or pull requests.

### How It Works

- Code changes pushed to the main branch trigger Terraform plans and applies via GitHub Actions (or other CI/CD systems).
- Secrets and credentials are securely stored as GitHub repository secrets.
- Terraform state is managed remotely (e.g., in Azure Storage or Terraform Cloud) and is **not stored locally or in this repository**.
- Sensitive files like `terraform.tfvars` are excluded from version control to protect secrets.

## Security Best Practices

- Secrets are stored securely in GitHub repository secrets or external secret managers.
- `.terraform.lock.hcl` is committed to ensure consistent provider versions.


## Notes for Workstation Management (Optional)

If you want to run Terraform locally for testing or troubleshooting:

- Clone the repo
- Create your own `terraform.tfvars` locally (excluded from Git)
- Run `terraform init`, `terraform plan`, and `terraform apply` as usual