variable "vpc_cidr" {
    type = string
    description = "vpc_cidr block"
    default = "192.168.0.0/16"
  
}
variable "web_subnet_cidr" {
    type = string
    description = "web subnet cidr block"
    default = "192.168.0.0/24"
  
}
variable "web_subnet_az" {
    type = string
    description = "web subnet availability zone"
    default = "ap-south-1a"
  
}
variable "app_subnet_cidr" {
    type = string
    description = "app subnet cidr block"
    default = "192.168.1.0/24"
  
}
variable "app_subnet_az" {
    type = string
    description = "app subnet availability zone"
    default = "ap-south-1a"
  
}
variable "db_subnet_cidr" {
    type = string
    description = "db subnet cidr block"
    default = "192.168.2.0/24"
  
}
variable "db_subnet_az" {
    type = string
    description = "db subnet availability zone"
    default = "ap-south-1a"
  
}
variable "security_group" {
  type = object({
    name =  string
    tags= map(string)
  })
 
}
variable "ingress_rules" {
    type = list(object({
     cidr_ipv4  = string
     from_port = number
     ip_protocol = string
     to_port = number
    }))
  
}
variable "egress_rules" {
    type = list(object({
      cidr_ipv4 = string
      ip_protocol = string
    }))
  
}