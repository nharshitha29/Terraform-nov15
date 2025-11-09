resource "aws_vpc" "base" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "from-tf"
    Env  = "Dev"
  }

}
resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.base.id
  availability_zone = var.web_subnet_az
  cidr_block        = var.web_subnet_cidr
  tags = {
    Name = "web"
    Env  = "Dev"

  }

}
resource "aws_subnet" "app" {
  vpc_id            = aws_vpc.base.id
  availability_zone = var.app_subnet_az
  cidr_block        = var.app_subnet_cidr
  tags = {
    Name = "app"
    Env  = "Dev"

  }

}
resource "aws_subnet" "db" {
  vpc_id            = aws_vpc.base.id
  availability_zone =var.db_subnet_az
  cidr_block        =var.db_subnet_cidr
  tags = {
    Name = "db"
    Env  = "Dev"

  }

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
  depends_on = [aws_subnet.app, aws_subnet.db]
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "public"
    Env  = "Dev"

  }
  depends_on = [aws_internet_gateway.igw, aws_subnet.web]
}

resource "aws_route" "route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_internet_gateway.igw, aws_route_table.public]


}
resource "aws_route_table_association" "public_web" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.web.id
}
resource "aws_route_table_association" "private_app" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.app.id

}

resource "aws_route_table_association" "private_db" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.db.id

}