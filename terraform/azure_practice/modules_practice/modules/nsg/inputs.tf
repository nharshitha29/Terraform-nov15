variable "resource_info_name" {
    type = string
  
}
variable "primary_location" {
  type    = string
  default = "Central India"

}

variable "network_security" {
  type = object({
    name = string
    location = string
  })

}
variable "security_rule" {
    type = list(object({
      name = string
      priority = number
      direction = string
      access                     = optional(string, "Deny")
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
}
  