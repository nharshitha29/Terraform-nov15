resource "azurerm_virtual_network" "primary" {
  name                = var.virtual_network_info.name
  resource_group_name = var.resource_info_name
  location            = var.virtual_network_info.location
  address_space       = [var.virtual_network_info.address_space]

}
resource "azurerm_subnet" "subnets" {
  count                           = length(var.primary_subnets)
  name                            = var.primary_subnets[count.index].name
  resource_group_name             = var.resource_info_name
  virtual_network_name            = azurerm_virtual_network.primary.name
  address_prefixes                = [var.primary_subnets[count.index].address_prefixes]
  default_outbound_access_enabled = var.primary_subnets[count.index].is_public_subnet
}