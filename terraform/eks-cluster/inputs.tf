variable "aws_region" {
  type = object({
    region = string
  })
  
}
variable "aws_vpc_info" {
    type = object({
      cidr_block = string 
      tags = map(string)
    })
  
}

variable "public_subnet" {
   type = list(object({
     cidr_block = string
     availability_zone = string
     tags = map(string) 
     })) 
  
}
variable "private_subnet" {
   type = list(object({
     cidr_block = string
     availability_zone = string
     tags = map(string) 
     })) 
  
}