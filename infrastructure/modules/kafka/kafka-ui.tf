resource "helm_release" "kafka_ui" {
  name       = "kafka-ui"
  repository = "https://provectus.github.io/kafka-ui-charts"
  chart      = "kafka-ui"
  namespace  = "default"

  set {
    name  = "envs.DYNAMIC_CONFIG_ENABLED"
    value = "true" 
  }

  set {
    name  = "envs.config.KAFKA_CLUSTERS_0_NAME"
    value = "local"
  }

  set {
    name  = "envs.config.KAFKA_BROKERCONNECT"
    value = "kafka:9092"
  }

  set {
    name  = "envs.config.KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS"
    value = "kafka:9092"
  }

  set {
    name = "envs.config.SERVER_SERVLET_CONTEXT_PATH"
    value = "/kafka-ui"
  }

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}