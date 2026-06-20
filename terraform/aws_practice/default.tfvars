region_vpc = {
  region = "us-east-1"
}
aws_vpc = {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "ntier"
  }
}
public_subnet = [{
  Name              = "web-1"
  cidr_block        = "192.168.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "web-1"
  } }, {
  Name              = "web-2"
  cidr_block        = "192.168.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "web-2"
  }
}]
private_subnet = [{
  Name              = "app-1"
  cidr_block        = "192.168.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "app-1"
  } },
  {
    Name              = "app-2"
    cidr_block        = "192.168.3.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "app-2"
    }
    }, {
    Name              = "db-1"
    cidr_block        = "192.168.5.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "db-1"
    }
    }, {
    Name              = "db-2"
    cidr_block        = "192.168.6.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "db-2"
    }
}]
ingress = [{
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  }, {
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
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