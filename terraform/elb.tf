provider "aws" {
  region = "us-east-1"
}

resource "aws_elb" "server_elb" {
  name               = "server-elb"
  availability_zones = ["${data.aws_availability_zones.available.names[0]}"]
  security_groups    = ["${aws_security_group.elb_sg.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${TF_VAR_certificateID}"
  }

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

}

resource "aws_iam_server_certificate" "cert" {
  name_prefix      = "ssl_cert"
  certificate_body = file("server.pem")
  private_key      = file("privatekey.pem")

  lifecycle {
    create_before_destroy = true
  }
}
