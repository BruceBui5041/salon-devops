output "network_config_outputs" {
  description = "Network Config State"
  value       = data.terraform_remote_state.network.outputs
}

output "spot_instance_id" {
  value = aws_spot_instance_request.proxy.spot_instance_id
}

output "spot_request_id" {
  value = aws_spot_instance_request.proxy.id
}

output "public_ip" {
  value = data.terraform_remote_state.proxy_eip.outputs.eip_proxy_public_ip
}
