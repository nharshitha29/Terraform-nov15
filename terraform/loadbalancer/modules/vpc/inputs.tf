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

