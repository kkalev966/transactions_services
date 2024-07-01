resource "kubernetes_ingress_v1" "ingress-grafana" {
  wait_for_load_balancer = true
  metadata {
    name = "ingress-grafana"
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      http {
        path {
          backend {
            service {
              name = "grafana"
              port {
                number = 80
              }
            }
          }
          path = "/grafana"
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "ingress-prometheus" {
  wait_for_load_balancer = true
  metadata {
    name = "ingress-prometheus"
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      http {
        path {
          backend {
            service {
              name = "prometheus-server"
              port {
                number = 80
              }
            }
          }
          path = "/"
        }
      }
    }
  }
}
