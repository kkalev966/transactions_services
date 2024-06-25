resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks-cluster"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "exampleaks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }
}

