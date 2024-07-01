variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "storage_container_name" {
  description = "The name of the storage container"
  type        = string
}

variable "storage_account_key_secret_name" {
  description = "The name of the storage account key secret"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the key vault"
  type        = string
}

variable "storage_account_key_secret" {
  description = "The secret of the storage account"
  type        = string
}

# variable "kafka_hostname" {
#   description = "The hostname for Kafka Ingress"
#   type        = string
# }

variable "kafka_topics" {
  description = "List of Kafka topics to create"
  type        = list(object({
    name             = string
    partitions       = number
    replication_factor = number
  }))
  default     = []
}