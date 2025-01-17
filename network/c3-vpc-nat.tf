# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_eip.vpc_eip.id
#   subnet_id     = aws_subnet.public.id

#   tags = {
#     Name = "salon-vpc-nat-gateway"
#   }

#   depends_on = [aws_internet_gateway.main]
# }
