# output "instance_publicip" {
#   description = "EC2 Instance Public IP"
#   value       = aws_instance.salon-dev.public_ip
# }

# output "instance_publicdns" {
#   description = "EC2 Instance Public DNS"
#   value       = aws_instance.salon-dev.public_dns
# }

# output "backend_remote_state_instance_publicip" {
#   description = "Backend Remote State Instance Public IP"
#   value       = data.terraform_remote_state.backend.outputs.instance_publicip
# }
