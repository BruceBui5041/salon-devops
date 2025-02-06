resource "aws_instance" "salon-dev-db" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = data.terraform_remote_state.network.outputs.public_subnet_id
  private_ip             = module.common_vars.db_private_ip
  vpc_security_group_ids = [aws_security_group.db_security_group.id]

  tags = {
    "Name" = "Salon Dev Database"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    tags = {
      Name = "Salon Dev Database EBS"
    }
  }

  # Your existing provisioners remain the same
  provisioner "remote-exec" {
    inline = ["echo 'Waiting for server to be initialized...'"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = self.public_ip
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
      host        = self.public_ip
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
      host        = self.public_ip
      timeout     = "4m"
    }
  }
}
