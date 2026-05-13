output "ip_address" {
  value = azurerm_linux_virtual_machine.webserver.public_ip_address
}
output "ssh_path" {
  value = format("ssh %s@%s", var.virtual_machine.admin_username, azurerm_linux_virtual_machine.webserver.public_ip_address)
  
}