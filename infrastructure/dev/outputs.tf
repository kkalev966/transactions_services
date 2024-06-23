output "network_public_ip_address" {
  value       = module.network.public_ip_address
  description = "The public IP address assigned to the network resources in the development environment."
}

output "aks_kube_config" {
  value       = module.aks.aks_cluster_kube_config
  description = "Kubernetes configuration file for the AKS cluster in the development environment."
  sensitive   = true
}

output "storage_account_name" {
  value       = module.storage.storage_account_name
  description = "Name of the Azure Storage Account created for the development environment."
}

output "storage_container_name" {
  value       = module.storage.storage_container_name
  description = "Name of the Azure Storage Container created for the development environment."
}

output "storage_account_primary_access_key" {
  value       = module.storage.storage_account_primary_access_key
  description = "Primary access key for the Azure Storage Account in the development environment."
  sensitive   = true
}

output "key_vault_name" {
  value       = azurerm_key_vault.example.name
  description = "Name of the Azure Key Vault used in the development environment."
}

output "key_vault_uri" {
  value       = azurerm_key_vault.example.vault_uri
  description = "URI of the Azure Key Vault used in the development environment."
}

# output "grafana_url" {
#   value       = "http://${module.prometheus.}"
#   description = "URL to access Grafana in the development environment."
# }

output "kafka_broker_service_url" {
  value       = "kafka.${module.network.public_ip_address}.nip.io"
  description = "URL to access Kafka brokers from external clients in the development environment."
}
