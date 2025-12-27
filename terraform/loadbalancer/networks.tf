resource "aws_vpc" "base" {
  cidr_block = var.aws_vpc.cidr_block
  tags       = var.aws_vpc.tags

}
resource "aws_subnet" "public" {
  count             = length(var.aws_subnet)
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.aws_subnet[count.index].cidr_block
  availability_zone = var.aws_subnet[count.index].availability_zone
  tags              = var.aws_subnet[count.index].tags
}
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "manual"
    Env  = "Dev"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "public"
    Env  = "Dev"

  }
  depends_on = [aws_internet_gateway.ig, aws_subnet.public]

}

resource "aws_route" "base" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.ig.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_internet_gateway.ig, aws_route_table.public]
}

resource "aws_route_table_association" "public" {
  count          = length(var.aws_subnet)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id

}
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "maunal-1"
    Env  = "Dev"
  }

}
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  count             = length(var.ingress)
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = var.ingress[count.index].cidr_ipv4
  from_port         = var.ingress[count.index].from_port
  ip_protocol       = var.ingress[count.index].ip_protocol
  to_port           = var.ingress[count.index].to_port

}
resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

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
resource "aws_instance" "base" {

  ami                         = data.aws_ami.ubuntu_primary.id
  subnet_id                   = aws_subnet.public[0].id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.primary.key_name
  vpc_security_group_ids      = [aws_security_group.sg.id]


}
resource "null_resource" "base" {
  triggers = {
    build_id = var.build_id
  }
  provisioner "remote-exec" {
    connection {
      host        = aws_instance.base.public_ip
      user        = "ubuntu"
      private_key = file("~/.ssh/id_ed25519")
    }
    inline = ["sudo apt update",
      "sudo apt install nginx unzip -y",
      "cd /tmp",
      "wget https://templatemo.com/tm-zip-files-2020/templatemo_604_christmas_piano.zip",
      "unzip templatemo_604_christmas_piano.zip",
      "cd templatemo_604_christmas_piano",
      "sudo cp -R . /var/www/html/",

    ]
  }
  depends_on = [aws_instance.base]
}