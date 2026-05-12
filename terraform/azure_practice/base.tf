resource "azurerm_resource_group" "example" {
  name     = var.resource_group_info.name
  location = var.resource_group_info.location
}