module "primary_vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.primary
  }
  vpc_info        = var.primary_info
  public_subnets  = var.public_info
  private_subnets = var.private_info
}




module "security_group" {
  source = "./modules/nsg"

  vpc_id = module.primary_vpc.vpc_id
  providers = {
    aws = aws.primary
  }
  security_group = var.security_group_info
  ingress_rules  = var.ingress_rules_info
  egress_rules   = var.egress_rules_info
}

resource "aws_key_pair" "primary" {
  public_key = file(var.key_path)
  region     = "ap-south-1"
  provider   = aws.primary
  key_name   = "primary"
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
  source            = "./modules/linux_vm"
  ami_id            = data.aws_ami.ubuntu_primary.id
  subnet_id         = module.primary_vpc.public_ids[0]
  security_group_id = module.security_group.security_group_id
  instance_type     = "t3.micro"
  key_name          = aws_key_pair.primary.key_name
  user_data         = file("./cloud_init.sh")
  build_id          = var.build_id

  providers = {
    aws = aws.primary
  }
}

