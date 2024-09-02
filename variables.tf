
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




