resource "aws_instance" "example" {
  ami                         = "ami-0c802847a7dd848c0" # Amazon Linux 2 in ap-southeast-1
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.vpc_security_group.id]

  tags = {
    Name = "example-instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              echo "<h1>Hello from EC2</h1>" > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
              EOF

}
