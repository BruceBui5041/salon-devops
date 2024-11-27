output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value       = aws_spot_instance_request.salon-dev.public_ip
}

output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value       = aws_spot_instance_request.salon-dev.public_dns
}

output "private_key_pem" {
  description = "Private key data in PEM format"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}

output "public_key_openssh" {
  description = "Public key data in OpenSSH authorized_keys format"
  value       = tls_private_key.ssh_key.public_key_openssh
}

output "spot_bid_status" {
  description = "Status of the spot bid"
  value       = aws_spot_instance_request.salon-dev.spot_bid_status
}

output "spot_request_state" {
  description = "State of the spot request"
  value       = aws_spot_instance_request.salon-dev.spot_request_state
}
