resource "aws_security_group" "ec2_security_group" {
  name        = "admin-panel-sg"
  description = "Security group for admin-panel instance"
  vpc_id      = data.terraform_remote_state.network.outputs.network_main_vpc_id

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP from proxy instance"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.network.outputs.public_subnet_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "admin-panel-security-group"
  }
}
