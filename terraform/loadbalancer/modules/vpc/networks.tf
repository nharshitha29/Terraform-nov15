resource "aws_vpc" "base" {
  cidr_block = var.aws_vpc.cidr_block
  tags       = var.aws_vpc.tags

}
resource "aws_subnet" "public" {
  count             = length(var.aws_subnet)
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.aws_subnet[count.index].cidr_block
  availability_zone = var.aws_subnet[count.index].availability_zone
  tags              = var.aws_subnet[count.index].tags
}
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "manual"
    Env  = "Dev"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "public"
    Env  = "Dev"

  }
  depends_on = [aws_internet_gateway.ig, aws_subnet.public]

}

resource "aws_route" "base" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.ig.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_internet_gateway.ig, aws_route_table.public]
}

resource "aws_route_table_association" "public" {
  count          = length(var.aws_subnet)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}