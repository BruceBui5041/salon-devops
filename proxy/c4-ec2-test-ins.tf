# resource "aws_instance" "example" {
#   ami           = "ami-0c802847a7dd848c0"
#   instance_type = "t2.nano"
#   subnet_id     = data.terraform_remote_state.network.outputs.public_subnet_id
#   #   associate_public_ip_address = false
#   vpc_security_group_ids = [aws_security_group.example_sg.id] # Use the correct security group

#   tags = {
#     Name = "example-instance"
#   }

#   user_data = <<-EOF
#               #!/bin/bash
#               # Update system packages
#               sudo yum update -y

#               # Install and configure Apache
#               sudo yum install -y httpd

#               # Update port configuration
#               sudo sed -i 's/Listen 80/Listen 3000/' /etc/httpd/conf/httpd.conf

#               # Configure SELinux to allow Apache on port 3000
#               sudo yum install -y policycoreutils-python
#               sudo semanage port -a -t http_port_t -p tcp 3000

#               # Add test webpage
#               echo "<h1>Hello from First EC2</h1>" > /var/www/html/index.html

#               # Set proper permissions
#               sudo chown -R apache:apache /var/www/html
#               sudo chmod -R 755 /var/www/html

#               # Disable SELinux temporarily for testing
#               sudo setenforce 0

#               # Start and enable Apache service
#               sudo systemctl start httpd
#               sudo systemctl enable httpd

#               # Allow port 3000 through firewall
#               sudo systemctl stop firewalld
#               sudo systemctl disable firewalld

#               # Verify Apache is running
#               sudo systemctl status httpd
#               EOF
# }
