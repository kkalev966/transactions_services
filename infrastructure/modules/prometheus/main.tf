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
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = var.load_balancer_ip
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = "default"

  set {
    name  = "server.global.scrape_interval"
    value = "15s"
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = "true"
  }
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = "default"

  set {
    name  = "adminUser"
    value = "admin"
  }

  set {
    name  = "adminPassword"
    value = "admin"
  }

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
    value = "/$2"
  }

  set {
    name  = "ingress.paths[0]"
    value = "/grafana(/|$)(.*)"
  }
}

