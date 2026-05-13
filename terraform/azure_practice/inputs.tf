variable "resource_group_info" {
  type = object({
    name     = string
    location = string
  })
}
variable "virtual_network_info" {
  type = object({
    name          = string
    address_space = string
  })


}
variable "primary_subnets" {
  type = list(object({
    name             = string
    address_prefixes = string
    is_public_sunbet = optional(bool, false)
  }))

}
variable "public_ip" {
  type = object({
    name = string
  })

}
variable "network_interface" {
  type = object({
    name = string
  })

}
variable "network_security" {
  type = object({
    name = string
  })

}
variable "ssh_rule" {
  type = object({
    name                   = string
    priority               = number
    destination_port_range = string
  })


}
variable "http_rule" {
  type = object({
    name                   = string
    priority               = number
    destination_port_range = string
  })


}
variable "virtual_machine" {
  type = object({
    name           = string
    size           = string
    admin_username = string
  })
}
variable "public_key" {
  type = object({
    key_path = optional(string, "~/.ssh/id_ed25519.pub")
  })
}
variable "image_refer" {
  type = object({
    publisher = string
    sku       = string
    version   = string
    offer     = string
  })

}