data "aws_security_group" "ec2_security_group" {
  name = "salon-db-security-group"
}

# # Create Security Group for EC2 Instance
# resource "aws_security_group" "ec2_security_group" {
#   # name        = "ec2-security-group"
#   name        = "salon-db-security-group"
#   description = "Security group for EC2 instance"

#   # SSH access
#   ingress {
#     description = "Allow Port 22"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # HTTP access
#   ingress {
#     description = "Allow Port 80"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # HTTPS access
#   ingress {
#     description = "Allow Port 443"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Custom port 2888
#   ingress {
#     description = "Allow Port 2888"
#     from_port   = 2888
#     to_port     = 2888
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # gRPC port
#   ingress {
#     description = "Allow Port 50051"
#     from_port   = 50051
#     to_port     = 50051
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Allow all outbound traffic
#   egress {
#     description = "Allow all outbound traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "ec2-security-group"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }