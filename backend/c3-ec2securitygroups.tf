resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Security group for backend instance"
  vpc_id      = data.terraform_remote_state.network.outputs.network_main_vpc_id

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.network.outputs.public_subnet_cidr]
  }

  ingress {
    description = "Allow HTTP from proxy instance"
    from_port   = 2888
    to_port     = 2888
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.network.outputs.public_subnet_cidr] # Allow access from the entire subnet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "backend-security-group"
  }
}
