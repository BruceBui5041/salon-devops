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

variable "proxy_eip_remote_state_key" {
  description = "Proxy EIP Remote State Key"
  type        = string
  default     = "proxy_eip/terraform.tfstate"
}
