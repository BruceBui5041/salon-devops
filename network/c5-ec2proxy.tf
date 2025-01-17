resource "aws_instance" "proxy" {
  ami                         = "ami-0c802847a7dd848c0"
  instance_type               = "t2.nano"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.vpc_security_group.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              cat > /etc/nginx/conf.d/proxy.conf <<'EOL'

              server {
                  listen 8081;
                  location / {
                      proxy_pass http://${aws_instance.example.private_ip}:8081;
                  }
              }

              EOL
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "proxy-instance"
  }
}
