variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "vault_uri" {
  type = string
}

variable "keyvault_id" {
  type = string
}

variable "oidc_issuer_url" {
  type = string
  description = "AKS OIDC issuer URL (output from the AKS module)"
}
