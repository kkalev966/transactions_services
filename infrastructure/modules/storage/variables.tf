variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "container_name" {
  description = "The name of the storage container"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the storage will be created"
  type        = string
}

variable "location" {
  description = "The location where the storage resources will be created"
  type        = string
}
