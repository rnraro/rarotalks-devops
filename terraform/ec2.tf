data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] 
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "mykey" {
  content  = tls_private_key.ssh.private_key_pem
  filename = "key/appserver.pem"
}

resource "aws_key_pair" "generated_key" {
  key_name    = var.key_name
  public_key  = tls_private_key.ssh.public_key_openssh
}

resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.ubuntu.id
  availability_zone           = var.aws_az
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.generated_key.key_name
  vpc_security_group_ids      = ["${aws_security_group.appserver_sg.id}"]
  subnet_id                   = aws_subnet.subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "App Server"
  }
  
  provisioner "file" {
    source      = "scripts/install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install.sh",
      "sudo /tmp/install.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.ssh.private_key_pem
    host        = aws_instance.app_server.public_ip
    timeout     = "1m"
  }
}