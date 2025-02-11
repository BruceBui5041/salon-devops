# resource "local_file" "env_file" {
#   content = templatefile("${path.module}/upload-files/dev.env.tpl", {
#     PUBLIC_IP      = data.terraform_remote_state.proxy_eip.outputs.eip_proxy_public_ip
#     BE_API         = module.common_vars.backend_private_ip
#     BASEPATH       = ""
#     BASE_HOST_PATH = "/api/apps"
#     API_URL        = "${data.terraform_remote_state.proxy_eip.outputs.eip_proxy_public_ip}:3000"
#   })
#   filename = "${path.module}/upload-files/dev.env"
# }

# Spot Instance Request for admin panel
resource "aws_spot_instance_request" "salon_admin_dev" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = data.terraform_remote_state.network.outputs.public_subnet_id
  private_ip             = module.common_vars.admin_panel_private_ip
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]


  spot_type            = "persistent"
  wait_for_fulfillment = true
  spot_price           = var.spot_price

  user_data = base64encode(<<-EOF
    #!/bin/bash
    
    # Create needed directories
    mkdir -p /home/ubuntu

    # Create .env file
    cat > /home/ubuntu/.env << 'ENV'
    ${file("${path.module}/upload-files/.env")}
    ENV
    
    # Create dev.env file
    cat > /home/ubuntu/.dev.env << 'ENV'
    ${templatefile("${path.module}/upload-files/dev.env.tpl", {
    PUBLIC_IP      = data.terraform_remote_state.proxy_eip.outputs.eip_proxy_public_ip
    BE_API         = module.common_vars.backend_private_ip
    BASEPATH       = ""
    BASE_HOST_PATH = "/api/apps"
    API_URL        = "${data.terraform_remote_state.proxy_eip.outputs.eip_proxy_public_ip}:3000"
})}
    ENV
    
    # Copy installation script
    cat > /home/ubuntu/app-install.sh << 'SCRIPT'
    ${file("${path.module}/upload-files/app-install.sh")}
    SCRIPT
    
    # Copy all other necessary files from upload-files directory
    # Add any additional files that need to be copied here
    
    # Set permissions
    chmod +x /home/ubuntu/app-install.sh
    chown -R ubuntu:ubuntu /home/ubuntu
    
    # Run installation
    cd /home/ubuntu
    sudo -u ubuntu ./app-install.sh
  EOF
)

root_block_device {
  volume_size = 8
  volume_type = "gp3"
  tags = {
    Name = "Salon Admin Panel EBS"
  }
}

tags = {
  Name = "Salon Dev Admin Panel"
}
}



# Handle all provisioning in a null resource
resource "null_resource" "setup_instance" {
  depends_on = [aws_spot_instance_request.salon_admin_dev]
  triggers = {
    # Track both the spot request ID and instance ID
    spot_request_id = aws_spot_instance_request.salon_admin_dev.id
    instance_id     = aws_spot_instance_request.salon_admin_dev.spot_instance_id
    # Track the instance state
    instance_state = aws_spot_instance_request.salon_admin_dev.instance_state
  }

  provisioner "file" {
    source      = "${path.module}/upload-files/"
    destination = "/home/ubuntu/"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = aws_spot_instance_request.salon_admin_dev.public_ip
      timeout     = "4m"
    }
  }
}
