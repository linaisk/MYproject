# ALB
resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.project-security-group.id]
  subnets            = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]

  enable_deletion_protection = false

  enable_http2 = true
  idle_timeout = 60

  enable_cross_zone_load_balancing = true

  tags = {
    Name = "my-alb"
  }

}
