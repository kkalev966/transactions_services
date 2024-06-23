output "aks_cluster_id" {
  value       = azurerm_kubernetes_cluster.example.id
  description = "The ID of the AKS cluster."
}

output "aks_cluster_name" {
  value       = azurerm_kubernetes_cluster.example.name
  description = "The name of the AKS cluster."
}

output "aks_cluster_node_resource_group" {
  value       = azurerm_kubernetes_cluster.example.node_resource_group
  description = "The name of the resource group where the AKS cluster nodes are located."
}

output "aks_cluster_kube_config" {
  value       = azurerm_kubernetes_cluster.example.kube_config
  description = "The kubeconfig for accessing the AKS cluster."
  sensitive   = true
}

output "aks_cluster_kube_admin_config" {
  value       = azurerm_kubernetes_cluster.example.kube_admin_config_raw
  description = "The administrator kubeconfig for accessing the AKS cluster."
  sensitive   = true
}

output "aks_cluster_kube_config_raw" {
  value       = azurerm_kubernetes_cluster.example.kube_config_raw
  description = "The raw kubeconfig for the AKS cluster as a string."
  sensitive   = true
}

output "aks_cluster_identity_principal_id" {
  value       = azurerm_kubernetes_cluster.example.identity.0.principal_id
  description = "The principal ID of the system assigned identity for the AKS cluster."
}

output "aks_cluster_identity_tenant_id" {
  value       = azurerm_kubernetes_cluster.example.identity.0.tenant_id
  description = "The tenant ID of the system assigned identity for the AKS cluster."
}

output "aks_cluster_fqdn" {
  value       = azurerm_kubernetes_cluster.example.fqdn
  description = "The fully qualified domain name of the AKS cluster."
}
