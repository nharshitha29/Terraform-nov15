resource "azurerm_resource_group" "base" {
  name     = var.resource_group_name
  location = var.location

}
module "primary_aks" {
  source              = "./module/aks"
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  default_node_pool = {
    name       = "aksdefault"
    node_count = 1
    vm_size    = "Standard_D4s_v3"
  }
  aks_info = {
    name       = "web-aks"
    dns_prefix = "azureaks"
  }
  build_id = "1"
 depends_on = [ azurerm_resource_group.base ]
}
