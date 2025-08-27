variable "dns_zone_name" {
  description = "DNS Zone name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the DNS zone will live"
  type        = string
}

variable "ingress_ip" {
  description = "Static public IP of the ingress controller"
  type        = string
}

variable "records" {
  description = "Map of A-records to create"
  type = map(object({
    name = string
    ttl  = number
  }))
}
