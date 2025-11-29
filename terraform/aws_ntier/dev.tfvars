region = "ap-south-1"
vpc_info = {
  cidr = "10.100.0.0/16"
  tags = {
    Name = "from-tf"
    Env  = "Dev"
  }
}

public_subnet = [{
  az   = "ap-south-1a"
  cidr = "10.100.0.0/24"
  tags = {
    Name = "web-1"
    Env  = "Dev"

  }
  }, {
  az   = "ap-south-1b"
  cidr = "10.100.3.0/24"
  tags = {
    Name = "web-2"
    Env  = "Dev"

  }
  }
]


private_subnet = [{
  az   = "ap-south-1a"
  cidr = "10.100.1.0/24"
  tags = {
    Name = "app-1"
    Env  = "Dev"
  }

  }, {
  az   = "ap-south-1b"
  cidr = "10.100.2.0/24"
  tags = {
    Name = "db-1"
    Env  = "Dev"
  }
  }, {
  az   = "ap-south-1a"
  cidr = "10.100.4.0/24"
  tags = {
    Name = "app-2"
    Env  = "Dev"
  }

  }, {
  az   = "ap-south-1b"
  cidr = "10.100.5.0/24"
  tags = {
    Name = "db-2"
    Env  = "Dev"
  }
  }
]
security_group = {
  name = "ntier"
  tags = {
    Name ="ntier"
    Env = "Dev"

  }
}
ingress_rules = [ {
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
},
{
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port = 80
  to_port = 80
},{
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port = 443
  to_port = 443
} ]
egress_rules = [ {
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
} ]
instance_type = "t3.micro"
key_name = "primary"
key_path = "~/.ssh/id_ed25519.pub"