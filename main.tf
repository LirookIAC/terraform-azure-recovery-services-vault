resource "azurerm_recovery_services_vault" "RSV" {
  name                = var.recovery_services_vault_name
  location            = var.recovery_services_vault_location
  resource_group_name = var.recovery_services_vault_resource_group_name
  sku                 = var.recovery_services_vault_sku
  storage_mode_type = var.storage_mode_type
  soft_delete_enabled = var.soft_delete_enabled
}