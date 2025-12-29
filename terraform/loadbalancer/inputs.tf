variable "region" {
  type = string

}
variable "aws_vpc_info" {
  type = object({
    cidr_block = string
    tags       = map(string)
  })

}
variable "aws_subnet_info" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))

}
variable "aws_security_group_info" {
    type = object({
      name = string
      tags = map(string)
    })
   }

variable "ingress_info" {
  type = list(object({
    cidr_ipv4   = string
    from_port   = number
    ip_protocol = string
    to_port     = number
  }))

}
variable "egress_info" {
    type = list(object({
      ip_protocol = string
      cidr_ipv4 = string
    }))
  
}

variable "primary_instance_type" {
  type    = string
  default = "t3.micro"
}
variable "key_name" {
  type = string

}
variable "key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"

}
variable "build_id" {
  type    = string
  default = "1"

}
variable "ubuntu_ami_name_pattern" {
  type    = string
  default = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

variable "canonical_owner_id" {
  type    = string
  default = "099720109477"
}