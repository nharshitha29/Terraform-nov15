resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_info.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.aks_info.dns_prefix

  default_node_pool {
    name       = var.default_node_pool.name
    node_count = var.default_node_pool.node_count
    vm_size    = var.default_node_pool.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = terraform.workspace
  }
  
}
resource "null_resource" "web" {

  triggers = {
    build_id = var.build_id
  }

  provisioner "local-exec" {

    command = "az aks get-credentials --resource-group ${var.resource_group_name} --name ${azurerm_kubernetes_cluster.aks.name} --overwrite-existing"
  }
  depends_on = [azurerm_kubernetes_cluster.aks]
}
