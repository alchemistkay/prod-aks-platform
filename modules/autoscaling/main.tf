resource "helm_release" "metrics_server" {
  name             = "metrics-server"
  namespace        = "kube-system"
  repository       = "https://kubernetes-sigs.github.io/metrics-server/"
  chart            = "metrics-server"
  version          = "3.13.0"
  create_namespace = false

  set = [{
    name  = "args"
    value = "{--kubelet-insecure-tls, --kubelet-preferred-address-types=InternalIP}"
  }]

  depends_on = [var.aks_dependency]
}

# Optional: Create HPAs for workloads or do it via the YAML
resource "kubernetes_horizontal_pod_autoscaler_v2" "this" {
  for_each = { for hpa in var.hpas : hpa.name => hpa }

  metadata {
    name      = each.value.name
    namespace = each.value.namespace
  }

  spec {
    scale_target_ref {
      api_version = each.value.target_api_version
      kind        = each.value.target_kind
      name        = each.value.target_name
    }

    min_replicas = each.value.min_replicas
    max_replicas = each.value.max_replicas

    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type               = "Utilization"
          average_utilization = each.value.cpu_utilization
        }
      }
    }

    metric {
      type = "Resource"
      resource {
        name = "memory"
        target {
          type               = "Utilization"
          average_utilization = each.value.memory_utilization
        }
      }
    }
  }
}
