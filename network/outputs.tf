output "aws_subnet_public_id" {
  description = "vpc subnet public id"
  value       = aws_subnet.public.id
}

output "network_main_vpc_id" {
  description = "main vpc id"
  value       = aws_vpc.main.id

}

output "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  value       = var.public_subnet_cidr
}

output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.public.id
}
