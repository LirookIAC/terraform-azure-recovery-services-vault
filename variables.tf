
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

variable "identity" {
  description = "Managed Service Identity configuration for the Recovery Services Vault."
  type = object({
    enable_identity = bool
    identity_type   = string
    identity_ids    = list(string)
  })
  default = {
    enable_identity = false
    identity_type   = "SystemAssigned"
    identity_ids    = []
  }

  validation {
    condition = (
      !var.identity.enable_identity ||
      (
        (var.identity.identity_type == "SystemAssigned" ||
         var.identity.identity_type == "UserAssigned" ||
         var.identity.identity_type == "SystemAssigned, UserAssigned") &&
        (var.identity.identity_type == "SystemAssigned" && length(var.identity.identity_ids) == 0) ||
        (var.identity.identity_type == "UserAssigned" && length(var.identity.identity_ids) > 0) ||
        (var.identity.identity_type == "SystemAssigned, UserAssigned" && length(var.identity.identity_ids) > 0)
      )
    )
    error_message = "When enable_identity is true, identity_type must be either 'SystemAssigned', 'UserAssigned', or 'SystemAssigned, UserAssigned'. If 'UserAssigned' is included in identity_type, identity_ids cannot be empty. If using only 'SystemAssigned', ensure identity_ids is either empty or not specified."
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

variable "encryption" {
  type = object({
    enable_encryption               = bool
    key_id                          = optional(string, null) 
    infrastructure_encryption_enabled = optional(bool, null)
    user_assigned_identity_id       = optional(string, null)
    use_system_assigned_identity    = optional(bool, true)
  })
  description = "Encryption settings for the Recovery Services Vault."

  default = {
    enable_encryption               = false
    key_id                          = null
    infrastructure_encryption_enabled =null
    user_assigned_identity_id       = null
    use_system_assigned_identity    = true
  }
  validation {
    condition = (
      !var.encryption.enable_encryption || (var.encryption.infrastructure_encryption_enabled!= null &&
        var.encryption.key_id != null && (var.encryption.user_assigned_identity_id == null || !var.encryption.use_system_assigned_identity)
      )
    )
    error_message = "When encryption is enabled, both key_id and infrastructure_encryption_enabled must be provided. Additionally, if user_assigned_identity_id is set, use_system_assigned_identity must be set to false."
  }
  
}












