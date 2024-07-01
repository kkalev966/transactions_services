resource "helm_release" "kafka" {
  name       = "kafka"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kafka"
  namespace  = "default" 
  values = [file("${path.module}/values.yaml")]

  dynamic "set" {
    for_each = var.kafka_topics
    content {
      name  = "topics[${set.key}].name"
      value = set.value.partitions
    }
  }

  dynamic "set" {
    for_each = var.kafka_topics
    content {
      name  = "topics[${set.key}].partitions"
      value = set.value.partitions
    }
  }

  dynamic "set" {
    for_each = var.kafka_topics
    content {
      name  = "topics[${set.key}].replicationFactor"
      value = set.value.replication_factor
    }
  }
}
# resource "helm_release" "kafka_exporter" {
#   name       = "kafka-exporter"
#   namespace  = "default"
#   chart      = "prometheus-kafka-exporter"
#   repository = "https://prometheus-community.github.io/helm-charts"

#   set {
#     name  = "logLevel"
#     value = "debug"
#   }

#   set {
#     name  = "replicaCount"
#     value = "1"
#   }

#   set {
#     name  = "service.type"
#     value = "ClusterIP"
#   }

#   set {
#     name  = "kafka.server"
#     value = "kafka-controller-0.kafka-controller-headless.default.svc.cluster.local:9092"  # Use the correct service name and namespace
#   }

#   depends_on = [helm_release.kafka]
# }


