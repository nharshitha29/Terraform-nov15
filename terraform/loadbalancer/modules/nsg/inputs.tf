variable "vpc_id" {
    type =string
  
}
variable "aws_security_group" {
    type = object({
      name = string
      tags = map(string)
    })
   }


variable "ingress" {
  type = list(object({
    cidr_ipv4   = string
    from_port   = number
    ip_protocol = string
    to_port     = number
  }))
}

variable "egress" {
    type = list(object({
      ip_protocol = string
      cidr_ipv4 = string
    }))
  
}