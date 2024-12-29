resource "aws_eip" "salon_dev_eip" {
  instance = aws_instance.salon-dev.id
  domain   = "vpc" # Required for EC2 instances in a VPC

  tags = {
    Name = "Salon Dev EIP"
  }
}
