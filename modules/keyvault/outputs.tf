output "keyvault_id" {
  value       = azurerm_key_vault.this.id
  description = "The resource ID of the Key Vault"
}

output "keyvault_uri" {
  value       = azurerm_key_vault.this.vault_uri
  description = "The URI of the Key Vault"
}
