variable "resource_info_name" {
    type = string
    default = "webserver"
  
}

variable "virtual_network_info" {
  type = object({
    name          = string
    address_space = string
    location = string
  })


}
variable "primary_subnets" {
  type = list(object({
    name             = string
    address_prefixes = string
    is_public_subnet = optional(bool, false)
  }))
}