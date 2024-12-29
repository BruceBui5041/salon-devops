resource "aws_instance" "salon-dev" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [data.aws_security_group.ec2_security_group.id]

  tags = {
    "Name" = "Salon Dev Backend"
  }

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

resource "aws_eip_association" "salon_dev_eip_assoc" {
  instance_id   = aws_instance.salon-dev.id
  allocation_id = data.aws_eip.shared_eip.id
}
