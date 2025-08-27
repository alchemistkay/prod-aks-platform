output "dns_zone_name" {
  value = azurerm_dns_zone.this.name
}

output "record_fqdns" {
  value = {
    for k, v in azurerm_dns_a_record.records :
    k => "${v.name}.${azurerm_dns_zone.this.name}"
  }
}
