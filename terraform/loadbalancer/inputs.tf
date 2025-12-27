variable "region" {
  type = string

}
variable "aws_vpc" {
  type = object({
    cidr_block = string
    tags       = map(string)
  })

}
variable "aws_subnet" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))

}
variable "ingress" {
  type = list(object({
    cidr_ipv4   = string
    from_port   = number
    ip_protocol = string
    to_port     = number
  }))

}
variable "instance_type" {
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