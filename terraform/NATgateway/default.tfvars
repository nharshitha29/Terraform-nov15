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
private_subnet = [{
  Name              = "app-1"
  cidr_block        = "192.168.2.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "app-1"
  }
}]
ingress = [{
  from_port   = 0
  to_port     = 0
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