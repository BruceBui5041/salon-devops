resource "local_file" "env_file" {
  content = templatefile("${path.module}/upload-files/dev.env.tpl", {
    EIP_PUBLIC_IP = data.terraform_remote_state.proxy_eip.outputs.eip_proxy_public_ip
  })
  filename = "${path.module}/upload-files/dev.env"
}

resource "aws_instance" "salon-dev" {
  depends_on = [local_file.env_file]

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = data.terraform_remote_state.network.outputs.public_subnet_id
  vpc_security_group_ids = [aws_security_group.backend_sg.id] # Use the correct security group

  tags = {
    "Name" = module.common_vars.backend_instance_tag_name
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    tags = {
      Name = "Salon Dev Backend EBS"
    }
  }
}




resource "null_resource" "setup_instance" {
  depends_on = [aws_instance.salon-dev]
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

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/app1-install.sh",
      "cd /home/ubuntu",
      "sudo ./app1-install.sh"
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
