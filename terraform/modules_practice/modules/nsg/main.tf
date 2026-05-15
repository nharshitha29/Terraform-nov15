resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security.name
  location            = var.network_security.location
  resource_group_name = var.resource_info_name
  }
resource "azurerm_network_security_rule" "openssh" {
    count = length(var.security_rule)
    resource_group_name = var.resource_info_name
    network_security_group_name = azurerm_network_security_group.nsg.name
    name                       = var.security_rule[count.index].name
    priority                   = var.security_rule[count.index].priority
    direction                  = var.security_rule[count.index].direction
    access                     = var.security_rule[count.index].access
    protocol                   = var.security_rule[count.index].protocol
    source_port_range          = var.security_rule[count.index].source_port_range
    destination_port_range     = var.security_rule[count.index].destination_port_range
    source_address_prefix      = var.security_rule[count.index].source_address_prefix
    destination_address_prefix = var.security_rule[count.index].destination_address_prefix
  
}
  
    
  
  