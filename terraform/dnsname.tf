output "elb_dns_name" {
  value = aws_elb.server_elb.dns_name
}
