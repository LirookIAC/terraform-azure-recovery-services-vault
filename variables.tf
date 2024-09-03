
variable "recovery_services_vault_name" {
  description = "Specifies the name of the Recovery Services Vault. Recovery Service Vault name must be 2 - 50 characters long, start with a letter, contain only letters, numbers, and hyphens."
  type        = string

  validation {
    condition     = length(var.recovery_services_vault_name) >= 2 && length(var.recovery_services_vault_name) <= 50
    error_message = "The Recovery Services Vault name must be between 2 and 50 characters long."
  }

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]*$", var.recovery_services_vault_name))
    error_message = "The Recovery Services Vault name must start with a letter and contain only letters, numbers, and hyphens."
  }

}

variable "recovery_services_vault_resource_group_name" {
  description = "The name of the resource group in which to create the Recovery Services Vault."
  type        = string
}

variable "recovery_services_vault_location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string

}


variable "recovery_services_vault_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "recovery_services_vault_sku" {
  description = "Sets the vault's SKU. Possible values include: Standard, RS0."
  type        = string
  default = "RS0"

  validation {
    condition     = var.recovery_services_vault_sku == "Standard" || var.recovery_services_vault_sku == "RS0"
    error_message = "The SKU must be either 'Standard' or 'RS0'."
  }
}

variable "soft_delete_enabled" {
  description = "Soft Delete Setting for vault. Defaults to fasle."
  type        = bool
  default     = false
}

variable "storage_mode_type" {
  description = "The storage type of the Recovery Services Vault. Possible values are GeoRedundant, LocallyRedundant, and ZoneRedundant."
  type        = string
  default     = "LocallyRedundant"
}

variable "public_network_access_enabled" {
  description = "Is it enabled to access the vault from public networks. Defaults to true."
  type        = bool
  default     = true
}

variable "recovery_services_vault_immutability" {
  description = "Immutability Settings of the vault. Possible values include: Locked, Unlocked, and Disabled."
  type        = string
  default = "Disabled"

  validation {
    condition     = var.recovery_services_vault_immutability == "Locked" || var.recovery_services_vault_immutability == "Unlocked" || var.recovery_services_vault_immutability == "Disabled"
    error_message = "The immutability setting must be one of the following: Locked, Unlocked, Disabled."
  }

}

variable "cross_region_restore_enabled" {
  type        = bool
  description = "Is cross-region restore to be enabled for this Vault?"
  default     = false
}

variable "classic_vmware_replication_enabled" {
  description = "Whether to enable the Classic experience for VMware replication. If set to false which is default, VMware machines will be protected using the new stateless ASR replication appliance. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "enable_identity" {
  description = "Whether to enable the Managed Service Identity configuration for the Recovery Services Vault. Set to true to include the identity block, false to omit it."
  type        = bool
  default     = false
}

variable "identity_type" {
  description = "Specifies the type of Managed Service Identity to be configured on the Recovery Services Vault. Possible values are: 'SystemAssigned', 'UserAssigned', or both 'SystemAssigned, UserAssigned'."
  type        = string
  default = "SystemAssigned"

  validation {
    condition     = var.identity_type == "SystemAssigned" || var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned, UserAssigned"
    error_message = "The identity_type must be either 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'. If you are not using identity please remove identity_type block from your configuration"
  }
}

variable "identity_ids" {
  description = "A list of User Assigned Managed Identity IDs to be assigned to this Recovery Services Vault. This is optional and only used if enable_identity is true."
  type        = list(string)
  default = [ "none" ]

  validation {
    condition     = length(var.identity_ids) > 0
    error_message = "The identity_ids list cannot be empty if identity type uses a UserAssigned managed identity. If you are only using SystemAssigned managed identity, or if you don't want to use identity please remove identity_ids from your configuration"
  }
}

variable "alerts_for_all_job_failures_enabled" {
  type        = bool
  description = "Enabling/Disabling built-in Azure Monitor alerts for security scenarios and job failure scenarios."
  default     = true
}

variable "alerts_for_critical_operation_failures_enabled" {
  type        = bool
  description = "Enabling/Disabling alerts from the older (classic alerts) solution."
  default     = false
}











