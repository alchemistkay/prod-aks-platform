resource "azurerm_dns_zone" "this" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_dns_a_record" "records" {
  for_each            = var.records
  name                = each.value.name
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = [var.ingress_ip]
}
