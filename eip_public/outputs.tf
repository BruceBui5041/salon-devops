output "eip_proxy_public_ip" {
  description = "Elastic IP Public IP"
  value       = aws_eip.proxy_eip.public_ip
}


output "eip_proxy_public_id" {
  description = "Elastic IP Public IP"
  value       = aws_eip.proxy_eip.id
}
