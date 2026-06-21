variable "aws_vpc" {
  type = object({
    cidr_block = string
    tags       = map(string)
  })
}

variable "public_subnet" {
  type = list(object({
    Name              = string
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))

}
variable "ingress" {
  type = list(object({
    cidr_ipv4   = string
    ip_protocol = string
  }))

}
variable "egress" {
  type = object({
    cidr_ipv4   = string
    ip_protocol = string
  })

}
variable "public_key" {
  type = object({
    key_name   = string
    public_key = optional(string, "C:/Users/91798/.ssh/id_ed25519.pub")
  })

}
variable "instance" {
  type = object({
    instance_type = string
    username      = string
  })

}

variable "secondary_aws_vpc" {
  type = object({
    cidr_block = string
    tags       = map(string)
  })
}
variable "secondary_private_subnet" {
  type = list(object({
    Name              = string
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))

}
variable "secondary_ingress" {
  type = list(object({
    cidr_ipv4   = string
    ip_protocol = string
  }))

}
variable "secondary_egress" {
  type = object({
    cidr_ipv4   = string
    ip_protocol = string
  })

}
variable "secondary_public_key" {
  type = object({
    key_name   = string
    public_key = optional(string, "C:/Users/91798/.ssh/id_ed25519.pub")
  })

}
variable "secondary_instance" {
  type = object({
    instance_type = string
    username      = string
  })

}