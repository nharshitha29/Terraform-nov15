resource "aws_vpc" "base" {
    cidr_block = var.aws_vpc_info.cidr_block
    tags = var.aws_vpc_info.tags
  
}
resource "aws_subnet" "public" {
    count = length(var.public_subnet)
    cidr_block = var.public_subnet[count.index].cidr_block
    vpc_id = aws_vpc.base.id
    availability_zone = var.public_subnet[count.index].availability_zone
    map_public_ip_on_launch = true
    tags = var.public_subnet[count.index].tags
    
}
resource "aws_subnet" "private" {
    count = length(var.private_subnet)
    cidr_block = var.private_subnet[count.index].cidr_block
    vpc_id = aws_vpc.base.id
    availability_zone = var.private_subnet[count.index].availability_zone
    tags = var.private_subnet[count.index].tags
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.base.id
    tags = {
        "Name" = "from-vpc"
    }
  }
resource "aws_route_table" "public_route" {
    vpc_id = aws_vpc.base.id
    tags = {
      "Name" = "public" 
    }
  
}
resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.base.id
    tags = {
      "Name" = "private" 
    }
  
}
resource "aws_route" "route" {
    route_table_id = aws_route_table.public_route.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    depends_on = [ aws_route_table.public_route,aws_internet_gateway.igw ]
  
}
resource "aws_route_table_association" "rta" {
    count = length(var.public_subnet)
    route_table_id = aws_route_table.public_route.id
    subnet_id = aws_subnet.public[count.index].id
    
}
resource "aws_route_table_association" "rtap" {
    count = length(var.private_subnet)
    route_table_id = aws_route_table.private_route.id
    subnet_id = aws_subnet.private[count.index].id
    
}