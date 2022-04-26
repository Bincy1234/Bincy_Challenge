resource "aws_autoscaling_group" "server_aasg" {
  launch_configuration = aws_launch_configuration.server_launch_config.id
  availability_zones   = ["${data.aws_availability_zones.available.names[0]}"]
  min_size             = var.min_size
  max_size             = var.max_size

  load_balancers    = ["${aws_elb.server_elb.name}"]
  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "server_aasg"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "server_aasg_policy" {
  name                   = "server_aasg_policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.server_aasg.name
}
