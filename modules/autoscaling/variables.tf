variable "aks_dependency" {
  description = "Dependency placeholder (e.g., AKS module)"
  type        = any
} 

variable "hpas" {
  description = "List of HPA configurations"
  type = list(object({
    name                = string
    namespace           = string
    target_api_version  = string
    target_kind         = string
    target_name         = string
    min_replicas        = number
    max_replicas        = number
    cpu_utilization     = number
    memory_utilization  = number
  }))
  default = []
}
