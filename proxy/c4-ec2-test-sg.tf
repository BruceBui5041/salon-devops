# resource "aws_security_group" "example_sg" {
#   name        = "example-sg"
#   description = "Security group for example instance"
#   vpc_id      = data.terraform_remote_state.network.outputs.network_main_vpc_id

#   ingress {
#     description = "Allow HTTP from proxy instance"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = [data.terraform_remote_state.network.outputs.public_subnet_cidr] # Allow access from the entire subnet
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "example-security-group"
#   }
# }
