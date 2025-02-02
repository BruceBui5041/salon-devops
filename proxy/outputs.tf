output "network_config_outputs" {
  description = "Network Config State"
  value       = data.terraform_remote_state.network.outputs
}

output "eip_proxy_public_ip" {
  description = "Elastic IP Public IP"
  value       = aws_eip.proxy_eip.public_ip
}
