output "ipaddress" {
  value = aws_instance.webservser.public_ip

}
output "ssh_path" {
  value = format("ssh %s@%s", var.instance.username, aws_instance.webservser.public_ip)

}