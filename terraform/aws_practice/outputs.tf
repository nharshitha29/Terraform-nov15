output "ipaddress" {
  value = aws_instance.webservser.public_ip

}
output "ipaddress1" {
  value = aws_instance.webservser1.public_ip

}


output "ssh_path" {
  value = format("ssh %s@%s", var.instance.username, aws_instance.webservser.public_ip)

}
output "ssh_path1" {
  value = format("ssh %s@%s", var.instance.username, aws_instance.webservser1.public_ip)

}