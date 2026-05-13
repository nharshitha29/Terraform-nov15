resource "azurerm_resource_group" "example" {
  name     = var.resource_info_name
  location = var.primary_location
}
module "primary_vpc" {
  source             = "./modules/vnet"
  resource_info_name = azurerm_resource_group.example.name
  virtual_network_info = {
    address_space = "10.10.0.0/16"
    name          = "from-tf"
    location      = "Central India"
  }
  primary_subnets = [{
    name             = "web-1"
    address_prefixes = "10.10.0.0/24"
    is_public_subnet = true
    },
    {
      name             = "app-1"
      address_prefixes = "10.10.1.0/24"
      is_public_subnet = true
    },
    {
      name             = "db-1"
      address_prefixes = "10.10.2.0/24"
      is_public_subnet = true
  }]

}
module "secondary_vpc" {
  source             = "./modules/vnet"
  resource_info_name = azurerm_resource_group.example.name
  virtual_network_info = {
    address_space = "10.101.0.0/16"
    name          = "ntier-tf"
    location      = "South India"
  }
  primary_subnets = [{
    name             = "web-1"
    address_prefixes = "10.101.0.0/24"
    is_public_subnet = true
    },
    {
      name             = "app-1"
      address_prefixes = "10.101.1.0/24"
      is_public_subnet = true
    },
    {
      name             = "db-1"
      address_prefixes = "10.101.2.0/24"
      is_public_subnet = true
  }]

}