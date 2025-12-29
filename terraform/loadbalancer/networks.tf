module "primary_vpc" {
   source = "./modules/vpc"
   providers = {
    aws = aws.primary
   }
   aws_vpc = var.aws_vpc_info
   aws_subnet = var.aws_subnet_info

}


module "security_group" {
  source = "./modules/nsg"
  providers = {
    aws = aws.primary
  }
  vpc_id = module.primary_vpc.vpc_id
  aws_security_group = var.aws_security_group_info
  ingress = var.ingress_info
  egress = var.egress_info

}

resource "aws_key_pair" "primary" {
  public_key = file(var.key_path)
  region     = "ap-south-1"
  provider   = aws.primary
  key_name   = var.key_name
}
data "aws_ami" "ubuntu_primary" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners   = ["099720109477"] # Canonical
  provider = aws.primary

}
module "primary_web" {
  source = "./modules/linux_vm"
  providers = {
    aws = aws.primary
  }

  ami                         = data.aws_ami.ubuntu_primary.id
  subnet_id                   = module.primary_vpc.public_ids[0]
  instance_type               = var.primary_instance_type
  key_name                    = aws_key_pair.primary.key_name
  security_group_id           = module.security_group.security_group_id
  build_id                    = var.build_id
  
}
