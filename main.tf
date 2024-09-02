resource "azurerm_recovery_services_vault" "RSV" {
  name                = var.recovery_services_vault_name
  location            = var.recovery_services_vault_location
  resource_group_name = var.recovery_services_vault_resource_group_name
  sku                 = var.recovery_services_vault_sku

  soft_delete_enabled = var.soft_delete_enabled
}