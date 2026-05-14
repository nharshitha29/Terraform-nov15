output "primary_vm_url" {
  value = format("http://%s", module.primary_vm.vm_ip)
}