resource "azurerm_resource_group" "example" {
  name     = var.resource_info_name
  location = var.primary_location
}


module "primary_vpc" {
  source               = "./modules/vnet"
  resource_info_name   = azurerm_resource_group.example.name
  virtual_network_info = var.primary_vpc_info
  primary_subnets      = var.primary_subnets_info
}

module "primary_nsg" {
  source             = "./modules/nsg"
  resource_info_name = azurerm_resource_group.example.name
  network_security   = var.primary_network_security
  security_rule      = var.primary_security_rule
}