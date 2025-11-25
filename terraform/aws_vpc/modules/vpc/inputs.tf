## required argument

variable "vpc_info" {
  type = object({
    cidr = string
    tags = map(string)
  })

  description = "vpc information"
}
variable "public_subnets" {
  type = list(object({
    cidr = string
    az = string
    tags = map(string) 
  }))
 description = "subnet information" 
}
variable "private_subnets" {
  type = list(object({
    cidr = string
    az = string
    tags = map(string) 
  }))
 description = "subnet information" 
}
