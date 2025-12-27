resource "aws_instance" "base" {

  ami                         = var.ami
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group_id]


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