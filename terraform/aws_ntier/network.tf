resource "aws_vpc" "base" {
  cidr_block = var.vpc_info.cidr
  tags       = var.vpc_info.tags
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnet)
  vpc_id            = aws_vpc.base.id
  availability_zone = var.public_subnet[count.index].az
  cidr_block        = var.public_subnet[count.index].cidr
  tags              = var.public_subnet[count.index].tags
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet)
  vpc_id            = aws_vpc.base.id
  availability_zone = var.private_subnet[count.index].az
  cidr_block        = var.private_subnet[count.index].cidr
  tags              = var.private_subnet[count.index].tags

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "manual"
    Env  = "Dev"

  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "private"
    Env  = "Dev"

  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_subnet.private]
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "public"
    Env  = "Dev"

  }
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_internet_gateway.igw, aws_subnet.public]
}

resource "aws_route" "route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_internet_gateway.igw, aws_route_table.public]


}
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet)
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private[count.index].id

}




resource "aws_security_group" "base" {
  
  vpc_id = aws_vpc.base.id
  name = var.security_group.name
  tags = var.security_group.tags
}
resource "aws_vpc_security_group_ingress_rule" "web_rules" {
    count = length(var.ingress_rules)
    security_group_id =aws_security_group.base.id
    cidr_ipv4         =   var.ingress_rules[count.index].cidr_ipv4      
    from_port         =var.ingress_rules[count.index].from_port
    ip_protocol       = var.ingress_rules[count.index].ip_protocol
    to_port           = var.ingress_rules[count.index].to_port
}

resource "aws_vpc_security_group_egress_rule" "web_rules" {
  count = length(var.egress_rules)
  security_group_id = aws_security_group.base.id
  cidr_ipv4         = var.egress_rules[count.index].cidr_ipv4
  ip_protocol       = var.egress_rules[count.index].ip_protocol
}


resource "aws_key_pair" "primary" {
  public_key = file(var.key_path)
  region     = "ap-south-1"
  provider   = aws.primary
  key_name   = "primary"
}
data "aws_ami" "ubuntu_primary" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners   = ["099720109477"] # Canonical
  provider = aws.primary


}

resource "aws_instance" "base" {
    count = length(var.public_subnet)
    ami = data.aws_ami.ubuntu_primary.id
    subnet_id = aws_subnet.public[count.index].id
    associate_public_ip_address = true
    instance_type = var.instance_type
    key_name = aws_key_pair.primary.key_name
    vpc_security_group_ids = [aws_security_group.base.id]
  
 
}

