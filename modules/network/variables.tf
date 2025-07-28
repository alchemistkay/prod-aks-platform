variable "vnet_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "tags" {
  type    = map(string)
  default = {}
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "aks_subnet_prefix" {
  default = "10.0.1.0/24"
}

variable "app_subnet_prefix" {
  default = "10.0.2.0/24"
}

variable "firewall_subnet_prefix" {
  default = "10.0.10.0/24"
}

variable "management_subnet_prefix" {
  default = "10.0.20.0/24"
}

variable "private_endpoints_subnet_prefix" {
  default = "10.0.21.0/24"
}

variable "project_name" {
  description = "Project/resource prefix"
  type        = string
}

