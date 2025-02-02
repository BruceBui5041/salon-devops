resource "aws_instance" "proxy" {
  ami                    = "ami-0c802847a7dd848c0"
  instance_type          = "t2.nano"
  subnet_id              = data.terraform_remote_state.network.outputs.aws_subnet_public_id
  vpc_security_group_ids = [aws_security_group.proxy_sg.id] # Use the correct security group

  user_data = <<-EOF
              #!/bin/bash
              # Update system packages
              sudo yum update -y

              # Install troubleshooting tools
              sudo yum install -y telnet nc

              # Install nginx using amazon-linux-extras
              sudo amazon-linux-extras enable nginx1
              sudo yum install -y nginx

              # Stop and disable firewalld
              sudo systemctl stop firewalld
              sudo systemctl disable firewalld

              # Create nginx configuration with debug logging
              cat > /etc/nginx/conf.d/proxy.conf <<'EOL'
              server {
                  listen 3000;
                  server_name localhost;
                  error_log /var/log/nginx/error.log debug;

                  location / {
                      proxy_pass http://${aws_instance.example.private_ip}:3000;
                      proxy_set_header Host $host;
                      proxy_set_header X-Real-IP $remote_addr;
                      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                      proxy_set_header X-Forwarded-Proto $scheme;
                      proxy_connect_timeout 300;
                      proxy_send_timeout 300;
                      proxy_read_timeout 300;
                  }
              }
              EOL

              # Remove default nginx configuration
              rm -f /etc/nginx/conf.d/default.conf

              # Start and enable nginx service
              sudo systemctl start nginx
              sudo systemctl enable nginx

              # Test network connectivity
              echo "Testing connection to example instance..."
              nc -zv ${aws_instance.example.private_ip} 3000
              EOF

  tags = {
    Name = "proxy-instance"
  }
}
