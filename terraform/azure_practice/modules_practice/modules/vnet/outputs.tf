output "vnet_name" {
    value = azurerm_virtual_network.primary.name
  
}
output "vnet_id" {
    value = azurerm_virtual_network.primary.id
  
}
output "subnets_name" {
    value = azurerm_subnet.subnets[*].name
  
}
output "subnet_ids" {
  value = azurerm_subnet.subnets[*].id
}