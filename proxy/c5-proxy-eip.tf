resource "aws_eip" "proxy_eip" {
  instance = aws_instance.proxy.id
  domain   = "vpc"

  tags = {
    Name = "salon-proxy-eip"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}
