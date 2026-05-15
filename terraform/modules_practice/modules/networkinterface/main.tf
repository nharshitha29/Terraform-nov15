resource "azurerm_public_ip" "public" {
  name                = var.public_ip.name
  location            = var.primary_location
  resource_group_name = var.resource_info_name
  allocation_method   = "Static"

}
resource "azurerm_network_interface" "primary_ni" {
  name                = var.network_interface.name
  location            = var.primary_location
  resource_group_name = var.resource_info_name
  ip_configuration {
    name                          = var.network_interface.name
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
    public_ip_address_id          = azurerm_public_ip.public.id
  }
}
resource "azurerm_network_interface_security_group_association" "web" {
  network_interface_id      = azurerm_network_interface.primary_ni.id
  network_security_group_id = var.security_group_id

}