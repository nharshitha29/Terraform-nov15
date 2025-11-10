--------------------------------
approach - 2
-------------------------------


resource "aws_vpc" "base" {
  cidr_block = var.vpc_info.cidr
  tags       = var.vpc_info.tags

}
resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.base.id
  availability_zone = var.web_subnet_info.az
  cidr_block        = var.web_subnet_info.cidr
  tags              = var.web_subnet_info.tags

}
resource "aws_subnet" "app" {
  vpc_id            = aws_vpc.base.id
  availability_zone = var.app_subnet_info.az
  cidr_block        = var.app_subnet_info.cidr
  tags              = var.app_subnet_info.tags

}
resource "aws_subnet" "db" {
  vpc_id            = aws_vpc.base.id
  availability_zone = var.db_subnet_info.az
  cidr_block        = var.db_subnet_info.cidr
  tags              = var.db_subnet_info.tags

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

----------------------------------------
approach - 3
----------------------------------------
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

