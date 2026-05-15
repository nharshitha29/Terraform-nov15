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
variable "build_id" {
  type    = string
  default = "1"
}
variable "primary_public_ip" {
  type = object({
    name = string
  })

}
variable "primary_network_interface" {
  type = object({
    name = string
  })

}
variable "primary_virtual_machine" {
  type = object({
    name           = string
    size           = string
    admin_username = string
  })

}
variable "primary_public_key" {
  type = object({
    key_path = string
  })

}
variable "primary_image_refer" {
  type = object({
    publisher = string
    offer     = string
    version   = string
    sku       = string
  })

}