output "network_config_outputs" {
  description = "Network Config State"
  value       = data.terraform_remote_state.network.outputs
}
