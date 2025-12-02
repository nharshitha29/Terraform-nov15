variable "key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"

}
variable "build_id" {
  type    = string
  default = "1"

}

variable "primary_region" {
  type    = string
  default = "ap-south-1"
}

variable "secondary_region" {
  type    = string
  default = "us-east-1"
}

variable "primary_info" {
  type = object({
    cidr = string
    tags = map(string)
    }
  )
}
variable "public_info" {
  type = list(object({
    cidr = string
    az   = string
    tags = map(string)
  }))
  description = "subnet information"
}
variable "private_info" {
  type = list(object({
    cidr = string
    az   = string
    tags = map(string)
  }))
  description = "subnet information"
}

variable "security_group_info" {
  type = object({
    name = string
    tags = map(string)
  })

}
variable "ingress_rules_info" {
  type = list(object({
    cidr_ipv4   = string
    from_port   = number
    ip_protocol = string
    to_port     = number
  }))

}
variable "egress_rules_info" {
  type = list(object({
    cidr_ipv4   = string
    ip_protocol = string
  }))

}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}


variable "ubuntu_ami_name_pattern" {
  type    = string
  default = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

variable "canonical_owner_id" {
  type    = string
  default = "099720109477"
}