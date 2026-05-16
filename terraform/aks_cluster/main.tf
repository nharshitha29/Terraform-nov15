resource "azurerm_resource_group" "base" {
  name     = var.resource_group_name
  location = var.location

}
module "primary_aks" {
  source              = "./module/aks"
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  default_node_pool = {
    name       = var.default_node_pool
    node_count = var.node_count
    vm_size    = var.vm_size
  }
  aks_info = {
    name       = var.aks_name
    dns_prefix = var.dns_prefix
  }
  build_id   = var.build_id
  depends_on = [azurerm_resource_group.base]
}
