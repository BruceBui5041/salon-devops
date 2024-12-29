data "aws_eip" "shared_eip" {
  filter {
    name   = "tag:Name"
    values = ["Salon Dev EIP"]
  }
}
