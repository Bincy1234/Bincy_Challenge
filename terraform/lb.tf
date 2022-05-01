provider "aws" {
  region = "us-east-1"
}

resource "aws_lb" "alb" {
  name               = "web-server-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnets

}

resource "aws_lb_target_group" "lb_target_group" {
  name     = "web-server-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

resource "aws_autoscaling_attachment" "attachement" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.lb_target_group.arn
}

output "lb_dns_name" {
  value = aws_lb.alb.dns_name
}
