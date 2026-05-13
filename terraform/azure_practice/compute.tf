resource "azurerm_linux_virtual_machine" "webserver" {
  name                  = var.virtual_machine.name
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  network_interface_ids = [azurerm_network_interface.primary_ni.id]
  size                  = var.virtual_machine.size
  admin_username        = var.virtual_machine.admin_username
  admin_ssh_key {
    username   = var.virtual_machine.admin_username
    public_key = file(var.public_key.key_path)
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = var.image_refer.publisher
    offer     = var.image_refer.offer
    sku       = var.image_refer.sku
    version   = var.image_refer.version
  }

}


