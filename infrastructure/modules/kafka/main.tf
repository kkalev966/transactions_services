resource "helm_release" "kafka" {
  name       = "kafka"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kafka"
  namespace  = "default" 
  values = [file("${path.module}/values.yaml")]

  # set {
  #   name  = "metrics.jmx.enabled"
  #   value = "true"
  # }

  # set {
  #   name = "serviceMonitor.enabled"
  #   value = "true"
  # }

  # set {
  #   name = "prometheusRule.enabled"
  #   value = "true"
  # }

  # set {
  #   name = "prometheusRule.namespace"
  #   value = "default"
  # }

  # set {
  #   name  = "controller.replicaCount"
  #   value = "1"
  # }

  # set {
  #   name  = "externalStorage.enabled"
  #   value = "true"
  # }

  # set {
  #   name  = "externalStorage.azure.accountName"
  #   value = var.storage_account_name
  # }

  # set {
  #   name  = "externalStorage.azure.containerName"
  #   value = var.storage_container_name
  # }

  # set {
  #   name  = "externalStorage.azure.accountKeySecretName"
  #   value = var.storage_account_key_secret_name
  # }

  # set {
  #   name  = "externalStorage.azure.keyVaultName"
  #   value = var.key_vault_name
  # }

  # set {
  #   name = "rbac.create"
  #   value = "true"
  # }

  # set {
  #   name = "controller.automountServiceAccountToken"
  #   value = true
  # }

  # set {
  #   name = "broker.automountServiceAccountToken"
  #   value = true
  # }

  # set {
  #   name  = "externalAccess.enabled"
  #   value = "true"
  # }

  # set {
  #   name  = "externalAccess.autoDiscovery.enabled"
  #   value = "true"
  # }

  # set {
  #   name = "provisioning.enabled"
  #   value = "true"
  # }


  # set {
  #   name = "topics[0].name"
  #   value = "Test"
  # }

  # set {
  #   name = "topics[0].partitions"
  #   value = 1
  # }

  # set {
  #   name = "topics[0].replicationFactor"
  #   value = 1
  # }

  # dynamic "set" {
  #   for_each = var.kafka_topics
  #   content {
  #     name  = "topics[${set.key}].partitions"
  #     value = set.value.partitions
  #   }
  # }

  # dynamic "set" {
  #   for_each = var.kafka_topics
  #   content {
  #     name  = "topics[${set.key}].replicationFactor"
  #     value = set.value.replication_factor
  #   }
  # }
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


