resource "kubernetes_ingress_v1" "ingress-kafka-ui" {
  wait_for_load_balancer = true
  metadata {
    name = "ingress-kafka-ui"
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      http {
        path {
          backend {
            service {
              name = "kafka-ui"
              port {
                number = 80
              }
            }
          }
          path = "/kafka-ui"
        }
      }
    }
  }
}