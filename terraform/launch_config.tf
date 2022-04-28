resource "aws_launch_configuration" "server_launch_config" {
  image_id        = "ami-0ac019f4fcb7cb7e6"
  instance_type   = var.instance_type
  security_groups = ["${aws_security_group.server_sg.id}"]
  key_name        = aws_key_pair.ec2_key.key_name
  user_data       = "${file("script.sh")}"
  lifecycle {
    create_before_destroy = true
  }
}
