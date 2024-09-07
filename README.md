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


# Usage

Below are the variables used for configuring the Azure Recovery Services Vault using Terraform:

### `recovery_services_vault_name`
Specifies the name of the Recovery Services Vault. The name must be between 2 and 50 characters long, start with a letter, and can only contain letters, numbers, and hyphens.

### `recovery_services_vault_resource_group_name`
The name of the resource group in which to create the Recovery Services Vault.

### `recovery_services_vault_location`
Specifies the supported Azure location where the resource exists.

### `recovery_services_vault_tags`
A mapping of tags to assign to the resource.

### `recovery_services_vault_sku`
Sets the vault's SKU. Possible values include: `Standard` and `RS0`.

### `soft_delete_enabled`
Soft Delete Setting for the vault. Defaults to `false`.

### `storage_mode_type`
The storage type of the Recovery Services Vault. Possible values are `GeoRedundant`, `LocallyRedundant`, and `ZoneRedundant`.

### `public_network_access_enabled`
Is it enabled to access the vault from public networks. Defaults to `true`.

### `recovery_services_vault_immutability`
Immutability settings of the vault. Possible values include: `Locked`, `Unlocked`, and `Disabled`.

### `cross_region_restore_enabled`
Is cross-region restore to be enabled for this vault?

### `classic_vmware_replication_enabled`
Whether to enable the classic experience for VMware replication. Defaults to `false`.

### `identity`
Managed Service Identity configuration for the Recovery Services Vault. It includes:
- `enable_identity`: Enable or disable Managed Service Identity.
- `identity_type`: Can be `SystemAssigned`, `UserAssigned`, or `SystemAssigned, UserAssigned`.
- `identity_ids`: A list of identity IDs to assign if `UserAssigned` is included in `identity_type`.

### `alerts_for_all_job_failures_enabled`
Enable or disable built-in Azure Monitor alerts for security scenarios and job failure scenarios. Defaults to `true`.

### `alerts_for_critical_operation_failures_enabled`
Enable or disable alerts from the older (classic alerts) solution. Defaults to `false`.

### `encryption`
Encryption settings for the Recovery Services Vault. The encryption object includes:
- `enable_encryption`: Enable or disable encryption.
- `key_id`: The Key Vault key ID used to encrypt the vault.
- `infrastructure_encryption_enabled`: Enable or disable double encryption.
- `user_assigned_identity_id`: The user-assigned identity ID, if applicable.
- `use_system_assigned_identity`: Whether to use the system-assigned identity. Defaults to `true`.

