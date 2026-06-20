resource "aws_vpc" "web" {
  provider   = aws.primary
  cidr_block = var.aws_vpc.cidr_block
  tags       = var.aws_vpc.tags
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_subnet" "public" {
  provider          = aws.primary
  count             = length(var.public_subnet)
  vpc_id            = aws_vpc.web.id
  cidr_block        = var.public_subnet[count.index].cidr_block
  availability_zone = var.public_subnet[count.index].availability_zone
  tags              = var.public_subnet[count.index].tags
  lifecycle {
    create_before_destroy = true
  }

}
resource "aws_subnet" "private" {
  provider          = aws.primary
  count             = length(var.private_subnet)
  vpc_id            = aws_vpc.web.id
  cidr_block        = var.private_subnet[count.index].cidr_block
  availability_zone = var.private_subnet[count.index].availability_zone
  tags              = var.private_subnet[count.index].tags
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_internet_gateway" "ig" {
  provider = aws.primary
  vpc_id   = aws_vpc.web.id
  tags = {
    Name = "ntier-igw"
  }
  lifecycle {
    create_before_destroy = true
  }

}
resource "aws_nat_gateway" "ngw" {
  provider          = aws.primary
  availability_mode = "regional"
  connectivity_type = "public"
  vpc_id            = aws_vpc.web.id
  tags = {
    Name = "private-nsg"
  }

}
resource "aws_route_table" "public_route" {
  provider = aws.primary
  vpc_id   = aws_vpc.web.id
  tags = {
    Name = "public-route"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route_table" "private_route" {
  provider = aws.primary
  vpc_id   = aws_vpc.web.id
  tags = {
    Name = "private-route"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route" "route_public" {
  provider               = aws.primary
  route_table_id         = aws_route_table.public_route.id
  gateway_id             = aws_internet_gateway.ig.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_internet_gateway.ig, aws_route_table.public_route]

}
resource "aws_route" "route_private" {
  provider               = aws.primary
  route_table_id         = aws_route_table.private_route.id
  gateway_id             = aws_nat_gateway.ngw.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_internet_gateway.ig, aws_route_table.private_route]

}
resource "aws_route_table_association" "public_association" {
  provider       = aws.primary
  count          = length(var.public_subnet)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_route.id

}
resource "aws_route_table_association" "private_association" {
  provider       = aws.primary
  count          = length(var.private_subnet)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_route.id

}
resource "aws_security_group" "sg" {
  provider = aws.primary
  vpc_id   = aws_vpc.web.id
  tags = {
    Name = "ntier-sg"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  provider          = aws.primary
  count             = length(var.ingress)
  security_group_id = aws_security_group.sg.id
  from_port         = var.ingress[count.index].from_port
  to_port           = var.ingress[count.index].to_port
  ip_protocol       = var.ingress[count.index].ip_protocol
  cidr_ipv4         = var.ingress[count.index].cidr_ipv4
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_vpc_security_group_egress_rule" "egress" {
  provider          = aws.primary
  security_group_id = aws_security_group.sg.id
  ip_protocol       = var.egress.ip_protocol
  cidr_ipv4         = var.egress.cidr_ipv4
  lifecycle {
    create_before_destroy = true
  }
}