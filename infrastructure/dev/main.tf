provider "azurerm" {
  features {}
}

provider "helm" {
   debug   = true
   kubernetes {
    host                   = module.aks.aks_cluster_kube_config.0.host
    client_certificate     = base64decode(module.aks.aks_cluster_kube_config.0.client_certificate)
    client_key             = base64decode(module.aks.aks_cluster_kube_config.0.client_key)
    cluster_ca_certificate = base64decode(module.aks.aks_cluster_kube_config.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
    host                   = module.aks.aks_cluster_kube_config.0.host
    client_certificate     = base64decode(module.aks.aks_cluster_kube_config.0.client_certificate)
    client_key             = base64decode(module.aks.aks_cluster_kube_config.0.client_key)
    cluster_ca_certificate = base64decode(module.aks.aks_cluster_kube_config.0.cluster_ca_certificate)
}

module "network" {
  source              = "../modules/network"
  resource_group_name = "example-dev-rg"
  location            = "northeurope"
}

module "aks" {
  source              = "../modules/aks"
  resource_group_name = module.network.resource_group_name
  location            = module.network.resource_group_location
}

module "storage" {
  source               = "../modules/storage"
  storage_account_name = "examplestorageacctdev"
  container_name       = "kafkacontainerdev"
  resource_group_name  = module.network.resource_group_name
  location             = module.network.resource_group_location
}

module ingress {
  source = "../modules/ingress"
}

module "kafka" {
  source                          = "../modules/kafka"
  storage_account_name            = module.storage.storage_account_name
  storage_container_name          = module.storage.storage_container_name
  storage_account_key_secret_name = "storageaccountkeydev"
  key_vault_name                  = "examplekeyvaultdev"
  storage_account_key_secret      = azurerm_key_vault_secret.storage_account_key.value   
  kafka_topics                    = [
    {
      name               = "transactions-dev"
      partitions         = 1
      replication_factor = 1
    },
    {
      name               = "authentication-dev"
      partitions         = 1
      replication_factor = 1
    },
    {
      name               = "notifications-dev"
      partitions         = 1
      replication_factor = 1
    },
  ]
}

module "prometheus" {
  source             = "../modules/prometheus"
  grafana_ip         = module.ingress.nginx_ingress_loadbalancer_ip
}

resource "azurerm_key_vault" "example" {
  name                        = "superkeyvaultdev"
  location                    = module.network.resource_group_location
  resource_group_name         = module.network.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
    ]
  }
}

resource "azurerm_key_vault_secret" "storage_account_key" {
  name         = "super-secret"
  value        = module.storage.storage_account_primary_access_key
  key_vault_id = azurerm_key_vault.example.id
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "example" {
  scope              = azurerm_key_vault.example.id
  role_definition_name = "Owner"
  principal_id       = module.aks.aks_cluster_identity_principal_id
}
