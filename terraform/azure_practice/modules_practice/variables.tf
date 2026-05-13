variable "resource_info_name" {
  type    = string
  default = "webserver"

}

variable "primary_location" {
  type    = string
  default = "Central India"

}
variable "primary_vpc_info" {
  type = object({
    name          = string
    address_space = string
    location      = string
  })
}
variable "primary_subnets_info" {
  type = list(object({
    name             = string
    address_prefixes = string
    is_public_subnet = bool
  }))

}
variable "primary_network_security" {
  type = object({
    name     = string
    location = string
  })
}
variable "primary_security_rule" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = optional(string, "Deny")
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))

}