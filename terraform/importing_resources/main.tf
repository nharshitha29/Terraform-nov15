##### vpc
resource "aws_vpc" "base" {

  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "ntier-vpc"
  }
  tags_all = {
    "Name" = "ntier-vpc"
  }
}

resource "aws_internet_gateway" "ig" {
    vpc_id   = aws_vpc.base.id
    
    
    tags     = {
        "Name" = "ntier-igw"
    }
    tags_all = {
        "Name" = "ntier-igw"
    }
depends_on = [ aws_vpc.base ]
}
resource "aws_subnet" "public_1" {
    vpc_id                                         = aws_vpc.base.id
    availability_zone                              = "ap-south-1a"
    cidr_block                                     = "10.0.0.0/20"
    tags                                           = {
        "Name" = "ntier-subnet-public1-ap-south-1a"
    }
    tags_all                                       = {
        "Name" = "ntier-subnet-public1-ap-south-1a"
    }
    
}
resource "aws_subnet" "public_2" {
    cidr_block                                     = "10.0.16.0/20"
    availability_zone                              = "ap-south-1b"
    tags                                           = {
        "Name" = "ntier-subnet-public2-ap-south-1b"
    }
    tags_all                                       = {
        "Name" = "ntier-subnet-public2-ap-south-1b"
    }
    vpc_id                                         = aws_vpc.base.id
}
resource "aws_subnet" "private_1" {
    vpc_id = aws_vpc.base.id
    
    availability_zone                              = "ap-south-1a"
    
    cidr_block                                     = "10.0.128.0/20"
    
    tags                                           = {
        "Name" = "ntier-subnet-private1-ap-south-1a"
    }
    tags_all                                       = {
        "Name" = "ntier-subnet-private1-ap-south-1a"
    }
}
resource "aws_subnet" "private_2" {
    vpc_id = aws_vpc.base.id
    
    availability_zone                              = "ap-south-1b"
   
    cidr_block                                     = "10.0.144.0/20"
    
    tags                                           = {
        "Name" = "ntier-subnet-private2-ap-south-1b"
    }
    tags_all                                       = {
        "Name" = "ntier-subnet-private2-ap-south-1b"
    }
    }
resource "aws_route_table" "public" {
    vpc_id           = aws_vpc.base.id
    route            = [
        {
            carrier_gateway_id         = null
            cidr_block                 = "0.0.0.0/0"
            core_network_arn           = null
            destination_prefix_list_id = null
            egress_only_gateway_id     = null
            gateway_id                 = aws_internet_gateway.ig.id
            ipv6_cidr_block            = null
            local_gateway_id           = null
            nat_gateway_id             = null
            network_interface_id       = null
            transit_gateway_id         = null
            vpc_endpoint_id            = null
            vpc_peering_connection_id  = null
        },
    ]
    tags             = {
        "Name" = "ntier-rtb-public"
    }
    tags_all         = {
        "Name" = "ntier-rtb-public"
    }
    depends_on = [ aws_subnet.public_1,aws_subnet.public_2 ]
}

resource "aws_route_table" "private" {
    vpc_id           = aws_vpc.base.id

    region           = "ap-south-1"
    route            = []
    tags             = {
        "Name" = "ntier-rtb-private1-ap-south-1a"
    }
    tags_all         = {
        "Name" = "ntier-rtb-private1-ap-south-1a"
    }
    depends_on = [ aws_subnet.private_1,aws_subnet.private_2]
}
resource "aws_security_group" "web" {
    
    description = "allows"
    egress      = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = null
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
        },
    ]
    
    ingress     = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = null
            from_port        = 22
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 22
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = null
            from_port        = 443
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 443
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = null
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
        },
    ]
    name        = "openhttpssh"
    
    region      = "ap-south-1"
    tags        = {
        "Name" = "openhttpssh"
    }
    tags_all    = {
        "Name" = "openhttpssh"
    }
    vpc_id      = aws_vpc.base.id
}
resource "aws_instance" "base" {
    ami                                  = "ami-02b8269d5e85954ef"
    associate_public_ip_address          = true
    
    instance_type                        = "t3.micro"
    
    key_name                             = "id_ed25519"
    region                               = "ap-south-1"
    
    subnet_id                            = aws_subnet.public_1.id
    tags                                 = {
        "Name" = "webserver-1"
    }
    tags_all                             = {
        "Name" = "webserver-1"
    }
    
    vpc_security_group_ids               = [
        aws_security_group.web.id,
    ]

}   

  