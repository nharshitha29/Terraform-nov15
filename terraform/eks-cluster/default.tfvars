aws_region = {
  region = "us-east-1"
}
aws_vpc_info = {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Env"  = "dev"
    "Name" = "web_vpc"
  }
}
public_subnet = [{
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "web-1"
    "Env"  = "dev"
  }
  },
  {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
      "Name" = "web-2"
      "Env"  = "dev"
    }
}]

private_subnet = [{
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "app-1"
    "Env"  = "dev"
  }
  },
  {
    cidr_block        = "10.0.3.0/24"
    availability_zone = "us-east-1b"
    tags = {
      "Name" = "app-2"
      "Env"  = "dev"
    }
}]