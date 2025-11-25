module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.5.0"
  cidr = "192.168.0.0/16"
  create_igw = true
  private_subnets = ["192.168.0.0/24","192.168.1.0/24","192.168.2.0/24"]
  private_subnet_names = [ "app-1","app-2","app-3" ]
  public_subnets = ["192.168.3.0/24","192.168.4.0/24","192.168.5.0/24"]
  public_subnet_names = [ "web-1","web-2","web-3"]
  azs = ["ap-south-1a","ap-south-1b","ap-south-1c"]
}