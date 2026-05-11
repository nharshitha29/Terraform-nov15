variable "region_vpc" {
  type = object({
    region = string
  })
}

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
variable "private_subnet" {
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
    from_port   = number
    to_port     = number
    ip_protocol = string
  }))

}
variable "egress" {
  type = object({
    cidr_ipv4   = string
    from_port   = number
    to_port     = number
    ip_protocol = string
  })

}
variable "public_key" {
  type = object({
    key_name   = string
    public_key = string
  })

}
variable "instance" {
  type = object({
    ami_id        = string
    instance_type = string
  })

}