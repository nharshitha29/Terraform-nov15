variable "cluster_name" {
    type = string
  
}
variable "role_arn" {
    type = string
  
}
variable "public_subnet_id" {
    type = list(string)
  
}
variable "private_subnet_id" {
    type = list(string)
  
}
variable "build_id" {
    type = number
  
}
variable "aws_region" {
  type = object({
    region = string
  })

}