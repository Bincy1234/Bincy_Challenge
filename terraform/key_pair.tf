resource "aws_key_pair" "ec2_key" {
  key_name   = "rsa-key"
  public_key = file("rsa-key.pub")
}
