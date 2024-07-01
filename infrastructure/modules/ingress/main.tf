resource "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "default"
  version    = "4.0.6"

  set {
    name = "controller.service.annotations.service.\\beta.\\kubernetes.io/azure-load-balancer-internal"
    value = "true"
  }
  set {
    name  = "controller.replicaCount"
    value = "2"
  }

  set {
    name = "controller.ingressClassResource.default"
    value = "true"
  }

  set {
    name = "controller.allowSnippetAnnotations"
    value = "true"
  }

  set {
    name = "kubernetes.io/ingress.class"
    value = "nginx"
  }

  set {
    name = "controller.service.externalTrafficPolicy"
    value = "Local"
  }
}

data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "nginx-ingress-ingress-nginx-controller"
    namespace = "default"
  }

  depends_on = [helm_release.nginx-ingress]
}