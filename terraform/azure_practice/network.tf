resource "azurerm_virtual_network" "primary" {
  name                = var.virtual_network_info.name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = [var.virtual_network_info.address_space]

}
resource "azurerm_subnet" "subnets" {
  count                           = length(var.primary_subnets)
  name                            = var.primary_subnets[count.index].name
  resource_group_name             = azurerm_resource_group.example.name
  virtual_network_name            = azurerm_virtual_network.primary.name
  address_prefixes                = [var.primary_subnets[count.index].address_prefixes]
  default_outbound_access_enabled = var.primary_subnets[count.index].is_public_sunbet
}
resource "azurerm_public_ip" "public" {
  name                = var.public_key.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"

}
resource "azurerm_network_interface" "primary_ni" {
  name                = var.network_interface.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  ip_configuration {
    name                          = var.network_interface.name
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnets[0].id
    public_ip_address_id          = azurerm_public_ip.public.id
  }
}
resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  security_rule {
    name                       = var.ssh_rule.name
    priority                   = var.ssh_rule.priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.ssh_rule.destination_port_range
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = var.http_rule.name
    priority                   = var.http_rule.priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.http_rule.destination_port_range
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}
resource "azurerm_network_interface_security_group_association" "web" {
  network_interface_id      = azurerm_network_interface.primary_ni.id
  network_security_group_id = azurerm_network_security_group.nsg.id

}