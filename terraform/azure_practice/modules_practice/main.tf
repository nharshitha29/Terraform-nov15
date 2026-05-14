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
  public_ip = {
    name = "web-ip"

  }
  network_interface = {
    name = "web-ni"
  }

}
module "primary_vm" {
  source               = "./modules/liunx_vm"
  resource_info_name   = azurerm_resource_group.example.name
  primary_location     = "Central India"
  network_interface_id = module.primary_ni.network_interface_id
  custom_data_info     = file("./cloud_init.sh")
  virtual_machine = {
    admin_username = "Dell"
    size           = "Standard_D2als_v6"
    name           = "primary-vm"
  }
  public_key = {
    key_path = "C:/Users/91798/.ssh/id_ed25519.pub"
  }
  image_refer = {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

}