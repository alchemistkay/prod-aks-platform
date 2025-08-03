output "login_server" {
  value       = azurerm_container_registry.this.login_server
  description = "ACR login server URL"
}

output "id" {
  value       = azurerm_container_registry.this.id
  description = "ACR resource ID"
}
