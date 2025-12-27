region = "ap-south-1"
aws_vpc = {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "from-tf"
    Env  = "Dev"
  }
}
aws_subnet = [{
  cidr_block        = "10.10.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "web-1"
    Env  = "Dev"
  } }, {
  cidr_block        = "10.10.1.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "web-2"
    Env  = "Dev"
  }
}]
ingress = [{
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
  }, {
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}]
key_name      = "primary"
instance_type = "t2.medium"