output "hpa_names" {
  value = [for h in kubernetes_horizontal_pod_autoscaler_v2.this : h.metadata[0].name]
}
