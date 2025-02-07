resource "local_file" "env_file" {
  content = templatefile("${path.module}/upload-files/dev.env.tpl", {
    PUBLIC_IP      = data.terraform_remote_state.proxy_eip.outputs.eip_proxy_public_ip
    BE_API         = module.common_vars.backend_private_ip
    BASEPATH       = ""
    BASE_HOST_PATH = "/api/apps"
    API_URL        = "${data.terraform_remote_state.proxy_eip.outputs.eip_proxy_public_ip}:3000"
  })
  filename = "${path.module}/upload-files/dev.env"
}

# Create the instance first without any provisioners
resource "aws_instance" "salon-dev" {
  depends_on             = [local_file.env_file]
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = data.terraform_remote_state.network.outputs.public_subnet_id
  private_ip             = module.common_vars.admin_panel_private_ip
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  tags = {
    "Name" = "Salon Dev Admin Panel"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    tags = {
      Name = "Salon Admin Panel EBS"
    }
  }
}

# Create the env file after instance is created


# Handle all provisioning in a null resource
resource "null_resource" "setup_instance" {
  depends_on = [aws_instance.salon-dev]

  # Wait for instance to be ready
  provisioner "remote-exec" {
    inline = ["echo 'Waiting for server to be initialized...'"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = aws_instance.salon-dev.public_ip
      timeout     = "4m"
    }
  }

  # Copy files after env file is created
  provisioner "file" {
    source      = "${path.module}/upload-files/"
    destination = "/home/ubuntu/"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = aws_instance.salon-dev.public_ip
      timeout     = "4m"
    }
  }

  # Run installation script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/app-install.sh",
      "cd /home/ubuntu",
      "sudo ./app-install.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = aws_instance.salon-dev.public_ip
      timeout     = "4m"
    }
  }
}
