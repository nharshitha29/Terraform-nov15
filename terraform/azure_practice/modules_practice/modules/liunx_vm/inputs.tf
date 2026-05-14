variable "resource_info_name" {
    type = string
  
}
variable "primary_location" {
  type    = string
  default = "Central India"

}
variable "network_interface_id" {
  type = string
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