resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = "default"
  values = [file("${path.module}/values.yaml")]

  # set {
  #   name  = "server.global.scrape_interval"
  #   value = "15s"
  # }

  # set {
  #   name  = "server.persistentVolume.enabled"
  #   value = "true"
  # }

  # set {
  #   name = "ingress.enabled"
  #   value = "true"
  # }
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
    name  = "env.GF_SERVER_ROOT_URL"
    value = "http://${var.grafana_ip}/grafana/"
  }

  set {
    name  = "env.GF_SERVER_SERVE_FROM_SUB_PATH"
    value = "true"
  }
}
