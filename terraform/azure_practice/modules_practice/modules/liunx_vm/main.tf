
resource "azurerm_linux_virtual_machine" "web" {
  name                  = var.virtual_machine.name
  resource_group_name   = var.resource_info_name
  location              = var.primary_location
  network_interface_ids = [var.network_interface_id]
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