output "aws_subnet_public_id" {
  description = "vpc subnet public id"
  value       = aws_subnet.public.id
}

output "proxy_eip" {
  description = "Proxy Elastic IP"
  value       = aws_eip.vpc_eip.public_ip
}

output "instance_private_ip" {
  description = "EC2 Instance Private IP"
  value       = aws_instance.example.private_ip
}
