resource_info_name = "webserver"
primary_location   = "Central India"
primary_vpc_info = {
  address_space = "10.10.0.0/16"
  name          = "from-tf"
  location      = "Central India"
}
primary_subnets_info = [{
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
primary_network_security = {
  name     = "primary_network"
  location = "Central India"
}
primary_security_rule = [{
  name                       = "openssh"
  priority                   = 200
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  direction                  = "Inbound"
  access                     = "Allow"
  }, {
  name                       = "openhttp"
  priority                   = 220
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  direction                  = "Inbound"
  access                     = "Allow"
  }
]
