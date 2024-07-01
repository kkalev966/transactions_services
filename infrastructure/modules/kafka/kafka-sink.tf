# resource "kubernetes_deployment" "kafka_sink_connector" {
#   metadata {
#     name      = "kafka-sink-connector"
#     namespace = "default"
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         app = "kafka-sink-connector"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "kafka-sink-connector"
#         }
#       }

#       spec {
#         container {
#           name  = "kafka-sink-connector"
#           image = "confluentinc/cp-kafka-connect:latest"

#           env {
#             name  = "CONNECT_BOOTSTRAP_SERVERS"
#             value = "kafka:9092"
#           }
          
#           env {
#             name  = "CONNECT_GROUP_ID"
#             value = "connect-cluster"
#           }

#           env {
#             name  = "CONNECT_CONFIG_STORAGE_TOPIC"
#             value = "connect-configs"
#           }

#           env {
#             name  = "CONNECT_OFFSET_STORAGE_TOPIC"
#             value = "connect-offsets"
#           }

#           env {
#             name  = "CONNECT_STATUS_STORAGE_TOPIC"
#             value = "connect-status"
#           }

#           env {
#             name  = "CONNECT_KEY_CONVERTER"
#             value = "org.apache.kafka.connect.storage.StringConverter"
#           }

#           env {
#             name  = "CONNECT_VALUE_CONVERTER"
#             value = "org.apache.kafka.connect.storage.StringConverter"
#           }

#           env {
#             name  = "CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR"
#             value = "1"
#           }

#           env {
#             name  = "CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR"
#             value = "1"
#           }

#           env {
#             name  = "CONNECT_STATUS_STORAGE_REPLICATION_FACTOR"
#             value = "1"
#           }

#           env {
#             name  = "CONNECT_PLUGIN_PATH"
#             value = "/usr/share/java,/etc/kafka-connect/jars"
#           }

#           volume_mount {
#             name       = "connector-config"
#             mount_path = "/etc/kafka-connect"
#             sub_path   = "sink-connector.properties"
#             read_only  = true
#           }
#         }

#         volume {
#           name = "connector-config"
#           config_map {
#             name = "kafka-sink-connector-config"
#           }
#         }
#       }
#     }
#   }
# }


# resource "kubernetes_config_map" "kafka_sink_connector" {
#   metadata {
#     name      = "kafka-sink-connector-config"
#     namespace = "default"
#   }
#   data = {
#     "sink-connector.properties" = <<-EOT
#       name=azure-sink-connector
#       connector.class=io.confluent.connect.azure.blob.AzureBlobStorageSinkConnector
#       tasks.max=1
#       topics=Test
#       azure.blob.storage.account.name=${var.storage_account_name}
#       azure.blob.storage.account.key=${var.storage_account_key_secret}
#       azure.blob.storage.container.name=${var.storage_container_name}
#       format.class=io.confluent.connect.azure.blob.format.avro.AvroFormat
#       flush.size=3
#       EOT
#   }
# }
