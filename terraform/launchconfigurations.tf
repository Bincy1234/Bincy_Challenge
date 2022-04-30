resource "aws_launch_configuration" "as_conf" {
  name_prefix     = "server config"
  image_id        = data.aws_ami.ubuntu.id
  user_data       = file("user-data.sh")
  security_groups = [aws_security_group.lc_sg.id]
  key_name        = aws_key_pair.deployer.key_name
  instance_type   = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "terraform-asg"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 1
  max_size             = 3
  health_check_grace_period = "300"
  vpc_zone_identifier  = module.vpc.public_subnets

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "asg_policy" {
  name                   = "server-asg-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}
