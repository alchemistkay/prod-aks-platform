variable "acr_name" {
  type        = string
  description = "Globally unique name for the Azure Container Registry"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the ACR"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "sku" {
  type        = string
  default     = "Premium"
  description = "ACR SKU: Basic, Standard, Premium"
}

variable "admin_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable the admin account. Recommended false for production."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the ACR resource"
}
