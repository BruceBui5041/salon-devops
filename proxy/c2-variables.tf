variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-southeast-1"
}

variable "proxy_ins_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.nano"
}
