resource "aws_eip" "vpc_eip" {
  instance = aws_instance.proxy.id
  domain   = "vpc"

  tags = {
    Name = "salon-vpc-eip"
  }
}
