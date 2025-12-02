key_path       = "~/.ssh/id_ed25519.pub"
build_id       = "1"
primary_region = "ap-south-1"
primary_info = {
  cidr = "10.101.0.0/16"
  tags = {
    Name = "from-tf"
    Env  = "Dev"
} }

public_info = [{
  cidr = "10.101.0.0/24"
  az   = "ap-south-1a"
  tags = {
    Name = "web-1"
    Env  = "Dev"
  }
  }, {
  cidr = "10.101.1.0/24"
  az   = "ap-south-1b"
  tags = {
    Name = "web-2"
    Env  = "Dev"
  } }
]
private_info= [{
  az   = "ap-south-1a"
  cidr = "10.101.2.0/24"
  tags = {
    Name = "app-1"
    Env  = "Dev"

  } }, {
  az   = "ap-south-1b"
  cidr = "10.101.3.0/24"
  tags = {
    Name = "app-2"
    Env  = "Dev"
  } },
  {
    az   = "ap-south-1a"
    cidr = "10.101.4.0/24"
    tags = {
      Name = "db-1"
      Env  = "Dev"

    }
  },
  {
    az   = "ap-south-1b"
    cidr = "10.101.5.0/24"
    tags = {
      Name = "db-2"
      Env  = "Dev"
    }
}]
security_group_info = {
  name = "manual"
  tags = {
    Name = "manual"
    Env  = "Dev"
  }
}
ingress_rules_info = [{
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
  }, {
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
  },
  { cidr_ipv4   = "0.0.0.0/0"
    from_port   = 443
    ip_protocol = "tcp"
    to_port     = 443
}]
egress_rules_info = [{
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}]
instance_type           = "t3.micro"
ubuntu_ami_name_pattern = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
canonical_owner_id      = "099720109477"