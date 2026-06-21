aws_vpc = {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "ntier"
  }
}
public_subnet = [{
  Name              = "web-1"
  cidr_block        = "192.168.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "web-1"
} }]
ingress = [{
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}]
egress = {
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
public_key = {
  key_name   = "webserver"
  public_key = "C:/Users/91798/.ssh/id_ed25519.pub"
}
instance = {
  instance_type = "t3.micro"
  username      = "ubuntu"
}
secondary_aws_vpc = {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "ntier1"
  }
}
secondary_private_subnet = [{
  Name              = "app-1"
  cidr_block        = "10.10.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "app-1"
  }
}]
secondary_ingress = [{
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}]
secondary_egress = {
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
secondary_public_key = {
  key_name   = "webserver1"
  public_key = "C:/Users/91798/.ssh/id_ed25519.pub"
}
secondary_instance = {
  instance_type = "t3.micro"
  username      = "ubuntu"
}