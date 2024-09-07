# Azure Recovery Services Vault Module

## Overview
This module creates an Azure Recovery Services Vault resource. The Recovery Services Vault helps manage and store backup data for Azure resources such as virtual machines, ensuring availability and protection of important workloads.

## Version Constraints

To ensure compatibility with this module, the following version constraints apply:

```hcl
terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.112.0, < 4.0.0"
    }
  }
}
```
**Terraform**: Tested with version 1.7.5  
**AzureRM Provider**: Tested with version 3.116.0

## Outputs
This module provides the following output:

```hcl
output "recovery_services_vault_id" {
  value = azurerm_recovery_services_vault.RSV.id
}
```
