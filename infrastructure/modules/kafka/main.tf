resource "helm_release" "kafka" {
  name       = "kafka"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kafka"
  namespace  = "default"

  set {
    name  = "externalStorage.enabled"
    value = "true"
  }

  set {
    name  = "externalStorage.azure.accountName"
    value = var.storage_account_name
  }

  set {
    name  = "externalStorage.azure.containerName"
    value = var.storage_container_name
  }

  set {
    name  = "externalStorage.azure.accountKeySecretName"
    value = var.storage_account_key_secret_name
  }

  set {
    name  = "externalStorage.azure.keyVaultName"
    value = var.key_vault_name
  }

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.hostname"
    value = var.kafka_hostname
  }

  set {
    name  = "ingress.annotations.kubernetes\\.io/ingress\\.class"
    value = "nginx"
  }

  # set {
  #   name  = "topics[${count.index}].name"
  #   value = var.kafka_topics[count.index].name
  # }

  # set {
  #   name  = "topics[${count.index}].partitions"
  #   value = var.kafka_topics[count.index].partitions
  # }

  # set {
  #   name  = "topics[${count.index}].replicationFactor"
  #   value = var.kafka_topics[count.index].replication_factor
  # }


  dynamic "set" {
    for_each = var.kafka_topics
    content {
      name  = "topics[${set.key}].name"
      value = set.value.name
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

