resource "kubernetes_cluster_role" "global_role" {
  count = var.scope == "cluster" && var.cluster_role_name == null ? 1 : 0

  metadata {
    name = var.role_name
  }

  rule {
    api_groups = var.api_groups
    resources  = var.resources
    verbs      = var.verbs
  }
}

resource "kubernetes_cluster_role_binding" "global_binding" {
  count = var.scope == "cluster" ? 1 : 0

  metadata {
    name = "${var.role_name}-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.cluster_role_name != null ? var.cluster_role_name : kubernetes_cluster_role.global_role[0].metadata[0].name
  }

  subject {
    kind      = var.subject_kind
    name      = var.subject_name
    api_group = "rbac.authorization.k8s.io"
  }
}
