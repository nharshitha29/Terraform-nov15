
resource "azurerm_linux_virtual_machine" "web" {
  name                  = var.virtual_machine.name
  resource_group_name   = var.resource_info_name
  location              = var.primary_location
  network_interface_ids = [var.network_interface_id]
  size                  = var.virtual_machine.size
  admin_username        = var.virtual_machine.admin_username
  custom_data = base64encode(var.custom_data_info)
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
resource "null_resource" "base" {
    triggers = {
      build_id = var.build_id
    }
    provisioner "remote-exec" {
    connection {
      host = azurerm_linux_virtual_machine.web.public_ip_address 
      private_key = file("C:/Users/91798/.ssh/id_ed25519")
      user = "Dell"
    }
    inline = [ "sudo apt update",
    "sudo apt install apache2 -y",
    "sudo apt install unzip -y"]
    
  }
  
}