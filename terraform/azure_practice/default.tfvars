resource_group_info = {
  name     = "ntier"
  location = "Central India"
}
virtual_network_info = {
  name          = "primary-vn"
  address_space = "10.0.0.0/16"
}
primary_subnets = [{
  name             = "web-1"
  address_prefixes = "10.0.0.0/24"
  is_public_sunbet = true
  },
  {
    name             = "app-1"
    address_prefixes = "10.0.1.0/24"
    is_public_sunbet = false
}]

public_ip = {
  name = "web-ip"
}

network_interface = {
  name = "ntier-web-interface"
}
network_security = {
  name = "ntier-web-security"
}
ssh_rule = {
  name                   = "openssh"
  priority               = 200
  destination_port_range = "22"
}
http_rule = {
  name                   = "openhttp"
  priority               = 250
  destination_port_range = "80"
}
virtual_machine = {
  name           = "web-ntier"
  size           = "Standard_D2als_v6"
  admin_username = "Dell"
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
  