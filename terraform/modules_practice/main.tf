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
module "primary_ni" {
  source             = "./modules/networkinterface"
  resource_info_name = azurerm_resource_group.example.name
  primary_location   = "Central India"
  subnet_id          = module.primary_vpc.subnet_ids[0]
  security_group_id  = module.primary_nsg.nsg_id
  public_ip          = var.primary_public_ip
  network_interface  = var.primary_network_interface

}
module "primary_vm" {
  source               = "./modules/liunx_vm"
  resource_info_name   = azurerm_resource_group.example.name
  primary_location     = "Central India"
  network_interface_id = module.primary_ni.network_interface_id
  custom_data_info     = file("./cloud_init.sh")
  build_id             = var.build_id
  virtual_machine      = var.primary_virtual_machine
  public_key           = var.primary_public_key
  image_refer          = var.primary_image_refer

}