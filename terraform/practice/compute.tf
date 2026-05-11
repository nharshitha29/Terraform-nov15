resource "aws_key_pair" "public_key" {
  key_name   = var.public_key.key_name
  public_key = file(var.public_key.public_key)

}
resource "aws_instance" "webservser" {
  ami                         = var.instance.ami_id
  instance_type               = var.instance.instance_type
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.public[0].id
  key_name                    = var.public_key.key_name
  associate_public_ip_address = true
  tags = {
    Name = "ntier-web"
  }

}