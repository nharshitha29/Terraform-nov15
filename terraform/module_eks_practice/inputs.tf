variable "aws_region" {
  type = object({
    region = string
  })

}
variable "build_id" {
  type = number

}
variable "vpc_info" {
  type = object({
    cidr_block = string
    tags       = map(string)
  })

}


variable "public_subnet_info" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))

}
variable "private_subnet_info" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))

}
variable "desired_size" {
  type = number

}
variable "max_size" {
  type = number

}
variable "min_size" {
  type = number

}
variable "max_unavailable" {
  type = number

}
variable "instance_types" {
  type = string
}