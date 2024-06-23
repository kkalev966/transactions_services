output "resource_group_name" {
  value = azurerm_resource_group.example.name
  description = "The name of the resource group."
}

output "resource_group_location" {
  value = azurerm_resource_group.example.location
  description = "The location of the resource group."
}

output "subnet_id" {
  value = azurerm_subnet.example.id
  description = "The ID of the subnet created."
}

output "public_ip_address" {
  value = azurerm_public_ip.example.ip_address
  description = "The public IP address allocated."
}
