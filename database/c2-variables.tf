variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-southeast-1"
}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t4g.micro"
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key Pair that need to be associated with EC2 Instance"
  type        = string
  default     = "terraform-key"
}

# Spot Price
variable "spot_price" {
  description = "Maximum spot price for the instance"
  type        = string
  default     = "0.02"
}

# Spot Type
variable "spot_type" {
  description = "Spot type (one-time or persistent)"
  type        = string
  default     = "persistent"
}