output "primary_web_url" {
  value = format("http://%s", module.primary_web.ip_address)

}

