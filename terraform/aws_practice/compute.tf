resource "aws_key_pair" "public_key" {
  key_name   = var.public_key.key_name
  public_key = file(var.public_key.public_key)
  lifecycle {
    create_before_destroy = true
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
resource "aws_instance" "webservser" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance.instance_type
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.public[0].id
  key_name                    = var.public_key.key_name
  associate_public_ip_address = true
  tags = {
    Name = "ntier-web"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "webservser1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance.instance_type
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.private[0].id
  key_name                    = var.public_key.key_name
  associate_public_ip_address = true
  tags = {
    Name = "ntier-web1"
  }
  lifecycle {
    create_before_destroy = true
  }
}