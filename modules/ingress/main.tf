resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  namespace  = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.chart_version

  create_namespace = true

  values = [
    yamlencode({
      controller = {
        replicaCount = 2
        service = {
          annotations = var.service_annotations
          loadBalancerIP = var.load_balancer_ip
        }
        publishService = {
          enabled = true
        }
      }
    })
  ]

  depends_on = [var.kubeconfig_depends_on]
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.18.2"

  create_namespace = true

  set = [{
    name  = "installCRDs"
    value = "true"
  }]

  depends_on = [var.kubeconfig_depends_on]
}

resource "null_resource" "apply_cluster_issuer" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/cluster-issuer.yaml"
  }

  depends_on = [
    helm_release.cert_manager
  ]
}
