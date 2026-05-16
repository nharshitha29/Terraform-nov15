variable "resource_group_name" {
  type    = string
  default = "manual"
}
variable "location" {
  type    = string
  default = "Central India"
}
variable "build_id" {
  type = string

}
variable "default_node_pool" {
  type = string

}
variable "node_count" {
  type = number

}
variable "vm_size" {
  type = string
}
variable "dns_prefix" {
  type = string

}
variable "aks_name" {
  type = string

}