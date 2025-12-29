region = "ap-south-1"
key_name      = "primary"
primary_instance_type = "t3.micro"
key_path = "~/.ssh/id_ed25519.pub"
build_id = "b-001"
ubuntu_ami_name_pattern = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
canonical_owner_id      = "099720109477"
aws_vpc_info = {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "from-tf"
    Env  = "Dev"
  }
}
aws_subnet_info = [{
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
ingress_info = [{
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
egress_info = [ {
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
} ]