region = "ap-south-1"
vpc_info = {
  cidr = "10.10.0.0/16"
  tags = {
    Name = "from-tf"
    Env  = "Dev"
  }
}

web_subnet_info = {
  az   = "ap-south-1a"
  cidr = "10.10.0.0/24"
  tags = {
    Name = "web"
    Env  = "Dev"
  }
}

app_subnet_info = {
  az   = "ap-south-1a"
  cidr = "10.10.1.0/24"
  tags = {
    Name = "app"
    Env  = "Dev"
  }
}

db_subnet_info = {
  az   = "ap-south-1a"
  cidr = "10.10.2.0/24"
  tags = {
    Name = "db"
    Env  = "Dev"
  }
}


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
} ]
egress_rules = [ {
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
} ]