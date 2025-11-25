resource "aws_vpc" "base" {
  cidr_block = var.vpc_info.cidr
  tags       = var.vpc_info.tags

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.base.id
  cidr_block = var.public_subnets[count.index].cidr
  availability_zone = var.public_subnets[count.index].az
  tags = var.public_subnets[count.index].tags
  depends_on = [ aws_vpc.base ]
}
resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.base.id
  cidr_block = var.private_subnets[count.index].cidr
  availability_zone = var.private_subnets[count.index].az
  tags = var.private_subnets[count.index].tags
  depends_on = [ aws_vpc.base ]
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "manual"
    Env  = "Dev"

  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "private"
    Env  = "Dev"

  }
  depends_on = [aws_subnet.private]
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "public"
    Env  = "Dev"

  }
  depends_on = [aws_internet_gateway.igw, aws_subnet.public]
}

resource "aws_route" "route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_internet_gateway.igw, aws_route_table.public]


}
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}


resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private[count.index].id

}
