
resource "aws_security_group" "db_security_group" {
  name        = "salon-db-sg"
  description = "Security group for EC2 instance"
  vpc_id      = data.terraform_remote_state.network.outputs.network_main_vpc_id

  # SSH access
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP from proxy instance"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.network.outputs.public_subnet_cidr]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "salon-db-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}
