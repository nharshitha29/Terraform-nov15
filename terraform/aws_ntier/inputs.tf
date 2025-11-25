variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "region information"

}

variable "vpc_info" {
  type = object({
    cidr = string
    tags = map(string)
  })

  default = {
    cidr = "192.168.0.0/16"
    tags = {
      Name = "from-tf"
      Env  = "Dev"
    }
  }
  description = "vpc information"
}

variable "public_subnet" {
  type = list(object({
    cidr = string
    az   = string
    tags = map(string)
  }))

  description = "public subnet"

}

variable "private_subnet" {
  type = list(object({
    cidr = string
    az   = string
    tags = map(string)
  }))

  description = "private subnet"

}
variable "vpc_id" {
  type = string
}
variable "security_group" {
    type = object({
      name = string
      tags = map(string)
    })
  
}
variable "ingress_rules" {
  type = list(object({
    cidr_ipv4  = string
    from_port = number
    ip_protocol =string
    to_port = number
  }))
  
}
variable "egress_rules" {
  type =list(object({
    cidr_ipv4 = string
    ip_protocol = string
  }))
  
}

