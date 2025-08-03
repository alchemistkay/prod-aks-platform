output "ingress_namespace" {
  value       = helm_release.nginx_ingress.namespace
  description = "Namespace where NGINX Ingress is deployed"
}

output "ingress_name" {
  value       = helm_release.nginx_ingress.name
  description = "Name of the Helm release"
}
