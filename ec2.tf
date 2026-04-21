# Générer une clé SSH
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Créer la paire de clés dans AWS
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.key.public_key_openssh
}

# Stocker la clé privée localement
resource "local_file" "private_key" {
  content         = tls_private_key.key.private_key_pem
  filename        = "${path.module}/deployer-key.pem"
  file_permission = "0600"
}

# Récupérer la dernière AMI Amazon Linux 2
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Instance EC2 avec Nginx
resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.web.name]
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install -y nginx1
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Hello from Terraform on AWS!</h1>" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = var.instance_name
  }
}
