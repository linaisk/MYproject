resource "aws_key_pair" "deployer" {
  key_name   = "deployer"
  public_key = file("~/.ssh/my_key.pub")
}

# EC2 Instances
resource "aws_instance" "bastion_host" {
  ami           = var.insAMI
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.project-security-group.id]


  user_data = <<-EOF
              #!/bin/bash
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "Welcome to Nginx Azim" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_instance" "private_ec2" {
  ami           = var.insAMI
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  subnet_id     = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.project-security-group.id]


  user_data = <<-EOF
              #!/bin/bash
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "Welcome to Nginx Azim" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "private-ec2"
  }
}

