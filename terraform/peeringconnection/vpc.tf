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
resource "aws_route" "internet" {
  provider                  = aws.primary
  route_table_id            = aws_route_table.public_route.id
  gateway_id                = aws_internet_gateway.ig.id
  destination_cidr_block    = "0.0.0.0/0"
  depends_on                = [aws_internet_gateway.ig, aws_route_table.public_route]

}
resource "aws_route" "peer" {
  provider                  = aws.primary
  route_table_id            = aws_route_table.public_route.id
  destination_cidr_block    = aws_vpc.web1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
  depends_on                = [aws_vpc_peering_connection.peering,aws_route_table.public_route]

}


resource "aws_route_table_association" "public_association" {
  provider       = aws.primary
  count          = length(var.public_subnet)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_route.id

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
resource "aws_vpc_peering_connection" "peering" {
  provider    = aws.primary
  vpc_id      = aws_vpc.web.id
  peer_vpc_id = aws_vpc.web1.id
  peer_region = "us-east-1"
  auto_accept = false
  tags = {
    Name = "public_peering"
  }
  depends_on = [aws_vpc.web, aws_vpc.web1]
}
resource "aws_vpc" "web1" {
  provider   = aws.secondary
  cidr_block = var.secondary_aws_vpc.cidr_block
  tags       = var.secondary_aws_vpc.tags
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_subnet" "sec_private" {
  provider          = aws.secondary
  count             = length(var.secondary_private_subnet)
  vpc_id            = aws_vpc.web1.id
  cidr_block        = var.secondary_private_subnet[count.index].cidr_block
  availability_zone = var.secondary_private_subnet[count.index].availability_zone
  tags              = var.secondary_private_subnet[count.index].tags
  lifecycle {
    create_before_destroy = true
  }

}
resource "aws_route_table" "private_route" {
  provider = aws.secondary
  vpc_id   = aws_vpc.web1.id
  tags = {
    Name = "private-route"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route" "route_private" {
  provider                  = aws.secondary
  route_table_id            = aws_route_table.private_route.id
  destination_cidr_block    = aws_vpc.web.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
  depends_on                = [aws_route_table.private_route]

}
resource "aws_route_table_association" "private_association" {
  provider       = aws.secondary
  count          = length(var.secondary_private_subnet)
  subnet_id      = aws_subnet.sec_private[count.index].id
  route_table_id = aws_route_table.private_route.id

}
resource "aws_security_group" "sg1" {
  provider = aws.secondary
  vpc_id   = aws_vpc.web1.id
  tags = {
    Name = "ntier-sg1"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_vpc_security_group_ingress_rule" "ingress1" {
  provider          = aws.secondary
  count             = length(var.secondary_ingress)
  security_group_id = aws_security_group.sg1.id
  ip_protocol       = var.secondary_ingress[count.index].ip_protocol
  cidr_ipv4         = var.secondary_ingress[count.index].cidr_ipv4
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_vpc_security_group_egress_rule" "egress1" {
  provider          = aws.secondary
  security_group_id = aws_security_group.sg1.id
  ip_protocol       = var.secondary_egress.ip_protocol
  cidr_ipv4         = var.secondary_egress.cidr_ipv4
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_vpc_peering_connection_accepter" "accept" {
  provider                  = aws.secondary
  vpc_peering_connection_id = aws_vpc_peering_connection.peering.id
  auto_accept               = true
  tags = {
    Name = "peering-accept"
  }
}
