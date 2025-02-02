variable "backend_instance_tag_name" {
  description = "Backend Instance Tag Name"
  type        = string
  default     = "Salon Dev Backend"
}

variable "remote_state_bucket" {
  description = "Backend Remote State Bucket Name"
  type        = string
  default     = "salon-terraform-state-dev"
}

variable "backend_remote_state_key" {
  description = "Backend Remote State Key"
  type        = string
  default     = "backend/terraform.tfstate"
}

variable "network_remote_state_key" {
  description = "VPC Remote State Key"
  type        = string
  default     = "network/terraform.tfstate"
}


variable "proxy_remote_state_key" {
  description = "Proxy Remote State Key"
  type        = string
  default     = "proxy/terraform.tfstate"
}
