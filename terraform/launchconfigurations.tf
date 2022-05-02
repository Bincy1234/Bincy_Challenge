resource "aws_launch_configuration" "as_conf" {
  name_prefix     = "web-server-"
  image_id        = data.aws_ami.ubuntu.id
  security_groups = [aws_security_group.lc_sg.id]
  key_name        = aws_key_pair.deployer.key_name
  instance_type   = "t2.micro"
  user_data = <<-EOF
              #!/bin/bash
              set -e
              sudo apt-get update
              sudo apt-get install -y python3 python3-pip virtualenv git vim curl
              git clone https://github.com/Bincy1234/Bincy_Challenge.git
              cd Bincy_Challenge
              virtualenv venv
              source venv/bin/activate
              pip3 install -r requirements.txt
              cd ansible
              echo "${var.vault_password}" > ~/.vault_pass.txt
              export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass.txt
              ansible-playbook default.yml
              curl -fsSL https://goss.rocks/install | sudo GOSS_DST=/usr/bin sh
              cd tests
              goss validate --format documentation > test.html
              sudo chown root. test.html
              sudo mv test.html /var/www/static_web_app/test/test.html
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "web-server-asg"
  launch_configuration      = aws_launch_configuration.as_conf.name
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = "300"
  vpc_zone_identifier       = module.vpc.public_subnets

  lifecycle {
    create_before_destroy = true
    ignore_changes = [ load_balancers, target_group_arns ]
  }
}

resource "aws_autoscaling_policy" "asg_policy" {
  name                   = "web-server-asg-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}
