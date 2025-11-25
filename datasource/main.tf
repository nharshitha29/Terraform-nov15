data "aws_vpc" "default" {
  region  = "ap-south-1"
  default = true
}
data "aws_vpc" "created_by_me" {
  region     = "ap-south-1"
  cidr_block = "10.101.0.0/16"
}