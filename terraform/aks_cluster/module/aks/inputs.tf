variable "resource_group_name" {
  type = string
  default = "manual"
}
variable "location" {
  type = string
  default = "Central India"
}
variable "aks_info" {
  type = object({
    name       = string
    dns_prefix = string
  })

}
variable "default_node_pool" {
  type = object({
    name       = string
    node_count = number
    vm_size    = string
  })

}
variable "build_id" {
    type = string
  
}