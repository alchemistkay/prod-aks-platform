resource "azurerm_container_registry" "this" {
  name                     = var.acr_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.sku
  admin_enabled            = var.admin_enabled
  public_network_access_enabled = false  # Enforce private access for use with  private endpoints

  tags = var.tags
}
