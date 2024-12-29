output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.salon-dev.public_ip
}

output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value       = aws_instance.salon-dev.public_dns
}

output "elastic_ip" {
  value       = data.aws_eip.shared_eip.public_ip
  description = "Elastic IP of the Salon Dev instance"
}
