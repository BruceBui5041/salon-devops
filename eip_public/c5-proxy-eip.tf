resource "aws_eip" "proxy_eip" {
  domain = "vpc"

  tags = {
    Name = "salon-proxy-eip"
  }
}
