resource "azurerm_virtual_machine" "webserver" {
  name = var.virtual_machine.name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  network_interface_ids = [ azurerm_network_interface.primary_ni.id ]
  vm_size = Standard_D2als_v6 
  username = "azureuser"
  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  storage_os_disk {
    caching              = "ReadWrite"
    name              = "myosdisk1"
    create_option     = "FromImage"
}
  
  
}

