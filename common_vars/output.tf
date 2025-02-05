

output "remote_state_bucket" {
  value = var.remote_state_bucket
}

output "backend_remote_state_key" {
  value = var.backend_remote_state_key
}

output "network_remote_state_key" {
  value = var.network_remote_state_key
}

output "proxy_remote_state_key" {
  value = var.proxy_remote_state_key
}

output "proxy_eip_remote_state_key" {
  value = var.proxy_eip_remote_state_key
}
