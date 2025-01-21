resource "aws_security_group" "example_sg" {
  name        = "example-sg"
  description = "Security group for example instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP from proxy instance"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet_cidr] # Allow access from the entire subnet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-security-group"
  }
}
