module "network" {
  source              = "../modules/network"
  resource_group_name = "example-staging-rg"
  location            = "West Europe"
}

module "aks" {
  source              = "../modules/aks"
  resource_group_name = module.network.resource_group_name
  location            = module.network.resource_group_location
}

module "storage" {
  source               = "../modules/storage"
  storage_account_name = "examplestorageacctstaging"
  container_name       = "kafkacontainerstaging"
  resource_group_name  = module.network.resource_group_name
  location             = module.network.resource_group_location
}

module "kafka" {
  source                          = "../modules/kafka"
  storage_account_name            = module.storage.storage_account_name
  storage_container_name          = module.storage.storage_container_name
  storage_account_key_secret_name = "storageaccountkeystaging"
  key_vault_name                  = "examplekeyvaultstaging"
  storage_account_key_secret      = azurerm_key_vault_secret.storage_account_key.value   
  kafka_topics                    = [
    {
      name               = "transactions-stage"
      partitions         = 1
      replication_factor = 1
    },
    {
      name               = "authentication-stage"
      partitions         = 1
      replication_factor = 1
    },
    {
      name               = "notifications-stage"
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
  name                        = "examplekeyvaultstaging"
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
  name         = "storageaccountkeystaging"
  value        = module.storage.storage_account_primary_access_key
  key_vault_id = azurerm_key_vault.example.id
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "example" {
  scope              = azurerm_key_vault.example.id
  role_definition_name = "Owner"
  principal_id       = module.aks.aks_cluster_identity_principal_id
}
