variable "chart_version" {
  type        = string
  default     = "4.13.0"
  description = "Version of the ingress-nginx Helm chart"
}

variable "service_annotations" {
  type        = map(string)
  default     = {}
  description = "Annotations for the LoadBalancer service"
}

variable "load_balancer_ip" {
  type        = string
  default     = null
  description = "Optional static IP to assign to the LoadBalancer"
}

variable "kubeconfig_depends_on" {
  description = "List of dependencies to ensure Kubernetes provider is ready"
  type        = list(any)
}
