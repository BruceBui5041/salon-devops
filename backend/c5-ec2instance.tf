# Spot Instance Request
resource "aws_spot_instance_request" "salon_dev" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = data.terraform_remote_state.network.outputs.public_subnet_id
  private_ip             = module.common_vars.backend_private_ip
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  spot_type            = "persistent"
  wait_for_fulfillment = true
  spot_price           = var.spot_price

  user_data = base64encode(<<-EOF
    #!/bin/bash
    
    # Create all needed files from upload-files directory
    mkdir -p /home/ubuntu/downloads
    
    # Create dev.env file
    cat > /home/ubuntu/dev.env << 'ENV'
    ${templatefile("${path.module}/upload-files/dev.env.tpl", {
    EIP_PUBLIC_IP          = data.terraform_remote_state.proxy_eip.outputs.eip_proxy_public_ip
    EIP_PRIVATE_IP         = module.common_vars.proxy_private_ip
    ADMIN_PANEL_PRIVATE_IP = module.common_vars.admin_panel_private_ip
    DB_PRIVATE_IP          = module.common_vars.db_private_ip
    DB_USER                = var.db_user
    DB_PASSWORD            = var.db_password
    REDIS_PASSWORD         = var.redis_password
    AWS_ACCESS_KEY_ID      = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY  = var.aws_secret_access_key
    AWS_ACCOUNT_ID         = var.aws_account_id
    OTP_SMS_API_KEY        = var.otp_sms_api_key
    OTP_SMS_API_SECRET_KEY = var.otp_sms_api_secret_key
})}
    ENV
    
    # Create app-install.sh
    cat > /home/ubuntu/app-install.sh << 'SCRIPT'
    ${file("${path.module}/upload-files/app-install.sh")}
    SCRIPT
    
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
    Name = "Salon Dev Backend EBS"
  }
}

tags = {
  Name = module.common_vars.backend_instance_tag_name
}
}

resource "null_resource" "setup_instance" {
  depends_on = [aws_spot_instance_request.salon_dev]
  triggers = {
    # Track both the spot request ID and instance ID
    spot_request_id = aws_spot_instance_request.salon_dev.id
    instance_id     = aws_spot_instance_request.salon_dev.spot_instance_id
    # Track the instance state
    instance_state = aws_spot_instance_request.salon_dev.instance_state
  }

  provisioner "file" {
    source      = "${path.module}/upload-files/project.tar.gz"
    destination = "/home/ubuntu/project.tar.gz"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = aws_spot_instance_request.salon_dev.public_ip
      timeout     = "4m"
    }
  }
}



# resource "null_resource" "setup_instance" {
#   depends_on = [aws_spot_instance_request.salon_dev]
#   provisioner "remote-exec" {
#     inline = [
#       "sudo tail -f /var/log/cloud-init-output.log",
#    ]

#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       private_key = tls_private_key.ssh_key.private_key_pem
#       host        = aws_spot_instance_request.salon_dev.spot_instance_id
#       timeout     = "4m"
#     }
#   }
# }
