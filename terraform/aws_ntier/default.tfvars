vpc_cidr        = "10.0.0.0/16"
web_subnet_az   = "ap-south-1a"
web_subnet_cidr = "10.0.0.0/24"
app_subnet_az   = "ap-south-1a"
app_subnet_cidr = "10.0.1.0/24"
db_subnet_az    = "ap-south-1a"
db_subnet_cidr  = "10.0.2.0/24"
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