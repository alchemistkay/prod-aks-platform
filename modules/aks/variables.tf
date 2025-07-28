variable "cluster_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "dns_prefix" {}
variable "aks_subnet_id" {}

variable "kubernetes_version" {
  default = "1.29.2"
}

variable "admin_group_object_ids" {
  type = list(string)
  default = ["7a704b2e-936e-428a-9e4b-d13cf47b410f"]
}

variable "enable_private_cluster" {
  default = true
}

variable "acr_id" {
  type        = string
  description = "The ACR resource ID to assign AcrPull to AKS managed identity"
}

# System node pool
variable "system_node_vm_size" {
  default = "Standard_D2_v5"
}
variable "system_node_count" {
  default = 1
}
variable "system_node_min_count" {
  default = 1
}
variable "system_node_max_count" {
  default = 3
}

# User node pool
variable "user_node_vm_size" {
  default = "Standard_D2_v5"
}
variable "user_node_count" {
  default = 2
}
variable "user_node_min_count" {
  default = 2
}
variable "user_node_max_count" {
  default = 5
}

# Spot Node Pool
variable "spot_node_vm_size" {
  default = "Standard_D2_v5"
}

variable "spot_node_count" {
  default = 1
}

variable "spot_node_min_count" {
  default = 1
}

variable "spot_node_max_count" {
  default = 5
}

variable "spot_max_price" {
  description = "Maximum price you're willing to pay for a Spot VM. Set to -1 for current market price."
  default     = -1.0
}

# Network config
variable "service_cidr" {
  default = "10.240.0.0/16"
}
variable "dns_service_ip" {
  default = "10.240.0.10"
}
# variable "docker_bridge_cidr" {
#   default = "172.17.0.1/16"
# }

variable "tags" {
  type    = map(string)
  default = {}
}


