variable "resource_info_name" {
    type = string
  
}
variable "primary_location" {
  type    = string
  default = "Central India"

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
variable "subnet_id" {
  type = string
}
variable "security_group_id" {
    type = string
  
}