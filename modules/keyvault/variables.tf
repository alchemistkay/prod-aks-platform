variable "keyvault_name" {
  type        = string
  description = "Name of the Azure Key Vault (must be globally unique)"
}

variable "location" {
  type        = string
  description = "Azure region for Key Vault"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group Key Vault will be created in"
}

variable "tenant_id" {
  type        = string
  description = "Azure Active Directory tenant ID"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the Key Vault"
}

variable "access_policies" {
  type = list(object({
    tenant_id = string
    object_id = string
    secret_permissions = optional(list(string), [])
    key_permissions    = optional(list(string), [])
    certificate_permissions = optional(list(string), [])
  }))
  default = []
  description = "List of access policies to assign"
}
