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
A mapping of tags to assign to the resource.Defaults to no tags.

### `recovery_services_vault_sku`
Sets the vault's SKU. Possible values include: `Standard` and `RS0`.Defaults to RS0.

### `soft_delete_enabled`
Soft Delete Setting for the vault. Defaults to `false`.

### `storage_mode_type`
The storage type of the Recovery Services Vault. Possible values are `GeoRedundant`, `LocallyRedundant`, and `ZoneRedundant`. Defaults to LocallyRedundant.

### `public_network_access_enabled`
Is it enabled to access the vault from public networks. Defaults to `true`.

### `recovery_services_vault_immutability`
Immutability settings of the vault. Possible values include: `Locked`, `Unlocked`, and `Disabled`. Disabled by default.

### `cross_region_restore_enabled`
Is cross-region restore to be enabled for this vault? Defaults to false. If set to true, storage_mode_type changes to GeoRedundant.

### `classic_vmware_replication_enabled`
Whether to enable the classic experience for VMware replication. Defaults to `false`.

### `identity`
Managed Service Identity configuration for the Recovery Services Vault. It includes:
- `enable_identity`: Enable or disable Managed Service Identity. Defaults to false.
- `identity_type`: Can be `SystemAssigned`, `UserAssigned`, or `SystemAssigned, UserAssigned`. Defaults to SystemAssigned.
- `identity_ids`: A list of identity IDs to assign if `UserAssigned` is included in `identity_type`.Defaults to [].
- Note : When enable_identity is true, identity_type must be either 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'. If 'UserAssigned' is included in identity_type, identity_ids cannot be empty. If using only 'SystemAssigned', ensure identity_ids is either empty or not specified.

### `alerts_for_all_job_failures_enabled`
Enable or disable built-in Azure Monitor alerts for security scenarios and job failure scenarios. Defaults to `true`.

### `alerts_for_critical_operation_failures_enabled`
Enable or disable alerts from the older (classic alerts) solution. Defaults to `false`.

### `encryption`
Encryption settings for the Recovery Services Vault. The encryption object includes:
- `enable_encryption`: Enable or disable encryption. Defaults to false
- `key_id`: The Key Vault key ID used to encrypt the vault.Defaults to null and need to be specified if enable_encryption is set to true.
- `infrastructure_encryption_enabled`: Enable or disable double encryption. Cannot be changed once set. Needs to be decided before vault creation. Changing this forces replacement. Defaults to null and must be specified.
- `user_assigned_identity_id`: The user-assigned identity ID, if applicable.Defaults to null and need to be specified if enable_encryption is set to true and user assigned managed identity is to be utilised.
- `use_system_assigned_identity`: Whether to use the system-assigned identity. Defaults to `true`. Must be set to false if user assigned managed identity is to be utilised.

## Considerations

When using this module, please keep the following in mind:

1. **Identity and Encryption Blocks**:
   - The `identity` and `encryption` blocks do not need to be declared if identity and encryption are not required for the Recovery Services Vault.
   
2. **Encryption Identity Privileges**:
   - Ensure that the identity being used for encryption has sufficient privileges to access and manage keys in the Azure Key Vault.

3. **Cross-Region Restore Impact**:
   - If cross-region restore is enabled, the `storage_mode_type` variable will automatically be overridden to `GeoRedundant`, regardless of its initial value.

## Example Usage

This section provides an example of how to use the Azure Recovery Services Vault module in your Terraform configuration.

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}


provider "azurerm" {
  features {}
}

module "recovery_services_vault" {
  source = "git::https://github.com/LirookIAC/terraform-azure-recovery-services-vault.git"

  # Pass any required variables to the module
  recovery_services_vault_resource_group_name = "test2"
  recovery_services_vault_location            = "North Europe"
  recovery_services_vault_name                = "myRecoveryVault"

  identity = {
    enable_identity      = true
    identity_type        = "SystemAssigned, UserAssigned"
    identity_ids         = [
      "/subscriptions/be0987b2-bb60-492d-92a9-d1641fb7adf8/resourceGroups/test2/providers/Microsoft.ManagedIdentity/userAssignedIdentities/RSV-test"
    ]
  }

  encryption = {
    enable_encryption                  = true
    key_id                             = "https://terraform-kv-lirook.vault.azure.net/keys/RSV-encryption/381898cd5b134bb0833877295af127fd"
    infrastructure_encryption_enabled  = true
    use_system_assigned_identity        = false
    user_assigned_identity_id           = "/subscriptions/be0987b2-bb60-492d-92a9-d1641fb7adf8/resourceGroups/test2/providers/Microsoft.ManagedIdentity/userAssignedIdentities/RSV-test"
  }
}

output "recovery_services_vault_id" {
  value = module.recovery_services_vault.recovery_services_vault_id
}
```



