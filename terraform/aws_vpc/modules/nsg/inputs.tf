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