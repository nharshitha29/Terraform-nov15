
output "primary_web_url" {
  value = format("http://%s", aws_instance.base.public_ip)

}