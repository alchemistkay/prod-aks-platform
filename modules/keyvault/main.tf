resource "azurerm_key_vault" "this" {
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id # tenant_id variable -> Azure AD tenant ID
  enabled_for_disk_encryption = true
  sku_name                   = "standard" # or "premium" if HSM is needed
  soft_delete_retention_days  = 7
  purge_protection_enabled   = true

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "this" {
  for_each = { for i, policy in var.access_policies : i => policy }

  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = each.value.tenant_id
  object_id    = each.value.object_id

  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  certificate_permissions = each.value.certificate_permissions
}

