resource "aws_launch_template" "mylaunchtemp" {
  name = "mylaunchtemp"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
      volume_type = "gp2"
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id      = aws_subnet.private_subnet.id
    security_groups     = [aws_security_group.project-security-group.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ASG-instance"
    }
  }

  instance_type = "t2.micro"
  image_id = var.insAMI
}

resource "aws_autoscaling_group" "my_asg" {
  desired_capacity        = 3
  max_size                = 5
  min_size                = 1
  health_check_type       = "EC2"
  health_check_grace_period = 300
  force_delete            = true
  launch_template {
    id      = aws_launch_template.mylaunchtemp.id
    version = "$Latest"
  }
  vpc_zone_identifier     = [aws_subnet.private_subnet.id]
}

