module "primary_vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.primary
  }
  vpc_info = {
    cidr = "10.101.0.0/16"
    tags = {
      Name = "primary"
      Env  = "Dev"
    }
  }
  public_subnets = [{
    az   = "ap-south-1a"
    cidr = "10.101.0.0/24"
    tags = {
      Name = "web-1"
      Env  = "Dev"
    }
    }, {
    az   = "ap-south-1b"
    cidr = "10.101.1.0/24"
    tags = {
      Name = "web-2"
      Env  = "Dev"
    }
  }]
  private_subnets = [

    {
      az   = "ap-south-1a"
      cidr = "10.101.2.0/24"
      tags = {
        Name = "app-1"
        Env  = "Dev"

      }
      }, {
      az   = "ap-south-1b"
      cidr = "10.101.3.0/24"
      tags = {
        Name = "app-2"
        Env  = "Dev"
      }
    },
    {
      az   = "ap-south-1a"
      cidr = "10.101.4.0/24"
      tags = {
        Name = "db-1"
        Env  = "Dev"

      }
      }, {
      az   = "ap-south-1b"
      cidr = "10.101.5.0/24"
      tags = {
        Name = "db-2"
        Env  = "Dev"
      }
  }]
}


module "secondary_vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.secondary
  }
  vpc_info = {
    cidr = "10.102.0.0/16"
    tags = {
      Name = "secondary"
      Env  = "Dev"
    }
  }
  public_subnets = [{
    az   = "us-east-1a"
    cidr = "10.102.0.0/24"
    tags = {
      Name = "web-1"
      Env  = "Dev"
    }
    }, {
    az   = "us-east-1b"
    cidr = "10.102.1.0/24"
    tags = {
      Name = "web-2"
      Env  = "Dev"
    }
  }]
  private_subnets = [

    {
      az = "us-east-1a"

      cidr = "10.102.2.0/24"
      tags = {
        Name = "app-1"
        Env  = "Dev"

      }
      }, {
      az = "us-east-1b"

      cidr = "10.102.3.0/24"
      tags = {
        Name = "app-2"
        Env  = "Dev"
      }
    },
    {
      az = "us-east-1a"

      cidr = "10.102.4.0/24"
      tags = {
        Name = "db-1"
        Env  = "Dev"

      }
      }, {
      az = "us-east-1b"

      cidr = "10.102.5.0/24"
      tags = {
        Name = "db-2"
        Env  = "Dev"
      }
  }]
}


module "security_group" {
  source = "./modules/nsg"

  vpc_id = module.primary_vpc.vpc_id
  providers = {
    aws = aws.primary
  }
  security_group = {
    name = "from-tf"
    tags = {
      Name = "from-tf"
    }
  }
  ingress_rules = [{
    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 22
    ip_protocol = "tcp"
    to_port     = 22
    }, {

    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 80
    ip_protocol = "tcp"
    to_port     = 80
    }, {

    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 443
    ip_protocol = "tcp"
    to_port     = 443
  }]
  egress_rules = [{
    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = "-1"
  }]
}




module "security_group_web" {
  source = "./modules/nsg"
  vpc_id = module.secondary_vpc.vpc_id
  providers = {
    aws = aws.secondary
  }
  security_group = {
    name = "manual"
    tags = {
      Name = "manual"
    }
  }
  ingress_rules = [{
    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 80
    ip_protocol = "tcp"
    to_port     = 80
    }, {

    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 22
    ip_protocol = "tcp"
    to_port     = 22
    }, {

    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 443
    ip_protocol = "tcp"
    to_port     = 443
  }]
  egress_rules = [{
    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = "-1"
  }]
}


resource "aws_key_pair" "primary" {
  public_key = file(var.key_path)
  region     = "ap-south-1"
  provider   = aws.primary
  key_name   = "primary"
}
resource "aws_key_pair" "secondary" {
  public_key = file(var.key_path)
  region     = "us-east-1"
  provider   = aws.secondary
  key_name   = "secondary"
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

data "aws_ami" "ubuntu_secondary" {
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
  provider = aws.secondary


}
module "secondary_web" {
  source            = "./modules/linux_vm"
  ami_id            = data.aws_ami.ubuntu_secondary.id
  subnet_id         = module.secondary_vpc.public_ids[0]
  security_group_id = module.security_group_web.security_group_id
  instance_type     = "t3.micro"
  key_name          = aws_key_pair.secondary.key_name
  user_data         = file("./cloud_init.sh")
  build_id          = var.build_id
  providers = {
    aws = aws.secondary
  }
}