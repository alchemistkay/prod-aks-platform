variable "scope" {
  description = "Either 'namespace' or 'cluster'"
  type        = string
}

variable "role_name" {
  type = string
}

variable "cluster_role_name" {
  type        = string
  default     = null
  description = "(Optional) Use an existing ClusterRole instead of creating one"
}

variable "namespace" {
  type    = string
  default = null
}

variable "api_groups" {
  type = list(string)
  default     = []
  description = "API groups this role applies to (ignored if using existing ClusterRole)"
}

variable "resources" {
  type = list(string)
  default     = []
  description = "Kubernetes resources this role applies to (ignored if using existing ClusterRole)"
}

variable "verbs" {
  type = list(string)
  default     = []
  description = "Allowed actions (verbs) for the specified resources (ignored if using existing ClusterRole)"
}

variable "subject_kind" {
  description = "Kind of subject: User, Group, or ServiceAccount"
  type        = string
}

variable "subject_name" {
  description = "Name of the subject"
  type        = string
}
