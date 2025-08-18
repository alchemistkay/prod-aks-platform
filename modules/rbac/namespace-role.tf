resource "kubernetes_role" "namespace_role" {
  count = var.scope == "namespace" ? 1 : 0

  metadata {
    name      = var.role_name
    namespace = var.namespace
  }

  rule {
    api_groups = var.api_groups
    resources  = var.resources
    verbs      = var.verbs
  }
}

resource "kubernetes_role_binding" "namespace_binding" {
  count = var.scope == "namespace" ? 1 : 0

  metadata {
    name      = "${var.role_name}-binding"
    namespace = var.namespace
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.namespace_role[0].metadata[0].name
  }

  subject {
    kind      = var.subject_kind
    name      = var.subject_name
    api_group = "rbac.authorization.k8s.io"
  }
}