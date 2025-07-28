output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "app_subnet_id" {
  value = azurerm_subnet.app.id
}

output "management_subnet_id" {
  value = azurerm_subnet.management.id
}

output "private_endpoints_subnet_id" {
  value = azurerm_subnet.private_endpoints.id
}

output "firewall_private_ip" {
  value = azurerm_firewall.main.ip_configuration[0].private_ip_address
}

output "firewall_public_ip" {
  value = azurerm_public_ip.firewall.ip_address
}

output "route_table_id" {
  value = azurerm_route_table.egress.id
}

output "ingress_public_ip" {
  value       = azurerm_public_ip.ingress.ip_address
  description = "The static public IP address for ingress controller"
}

output "ingress_public_ip_name" {
  value       = azurerm_public_ip.ingress.name
  description = "The name of the reserved static public IP"
}
