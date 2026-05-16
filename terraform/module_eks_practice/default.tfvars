aws_region = {
  region = "us-east-1"
}
build_id = 1
vpc_info = {

  cidr_block = "10.0.0.0/16"
  tags = {
    "Env"  = "dev"
    "Name" = "web_vpc"
  }

}
public_subnet_info = [{
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
private_subnet_info = [{
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
desired_size    = 2
max_size        = 3
min_size        = 2
max_unavailable = 1
instance_types  = "t3.small"
cluster_name    = "first-cluster"
node_group_name = "first-nodegroup"