data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] 
}

resource "tls_private_key" "ssh-key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "local-ssh-key" { 
  filename = "${path.module}/key/${var.key_name}"
  content = tls_private_key.ssh-key.private_key_pem

  provisioner "local-exec" {
    command = <<-EOT
        echo '${tls_private_key.ssh-key.private_key_pem}' > 'key/${var.key_name}'
        chmod 600 'key/${var.key_name}'
      EOT
    }
}

resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.ubuntu.id
  availability_zone           = var.aws_az
  instance_type               = "t2.micro"
  key_name                    = tls_private_key.ssh-key.private_key_pem
  vpc_security_group_ids      = ["${aws_security_group.appserver_sg.id}"]
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "App Server"
  }
  user_data = "${file("scripts/install.sh")}"
}