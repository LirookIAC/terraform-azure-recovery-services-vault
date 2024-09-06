resource "azurerm_recovery_services_vault" "RSV" {
  name                = var.recovery_services_vault_name
  location            = var.recovery_services_vault_location
  resource_group_name = var.recovery_services_vault_resource_group_name
  sku                 = var.recovery_services_vault_sku
  storage_mode_type = var.cross_region_restore_enabled ? "GeoRedundant" : var.storage_mode_type
  soft_delete_enabled = var.soft_delete_enabled
  immutability = var.recovery_services_vault_immutability
  public_network_access_enabled = var.public_network_access_enabled
  classic_vmware_replication_enabled = var.classic_vmware_replication_enabled
  cross_region_restore_enabled = var.cross_region_restore_enabled
  dynamic "identity" {
    for_each = var.identity.enable_identity ? [1] : []
    content {
      type = var.identity.identity_type
      identity_ids = var.identity.identity_ids
    }
  }
  monitoring {
    alerts_for_all_job_failures_enabled = var.alerts_for_all_job_failures_enabled
    alerts_for_critical_operation_failures_enabled = var.alerts_for_critical_operation_failures_enabled
  }
  dynamic "encryption" {
    for_each = var.encryption.enable_encryption ? [1] : []
    content {
      key_id                        = var.encryption["key_id"]
      infrastructure_encryption_enabled = var.encryption["infrastructure_encryption_enabled"]
      user_assigned_identity_id     = var.encryption["user_assigned_identity_id"]
      use_system_assigned_identity  = var.encryption["use_system_assigned_identity"]
    }
  }
  
}