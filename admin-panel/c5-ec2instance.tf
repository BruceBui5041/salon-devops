# Create the instance first without any provisioners
resource "aws_instance" "salon-dev" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [data.aws_security_group.ec2_security_group.id]

  tags = {
    "Name" = "Salon Dev Admin Panel"
  }
}

# Create the env file after instance is created
resource "local_file" "env_file" {
  content = templatefile("${path.module}/upload-files/dev.env.tpl", {
    PUBLIC_IP      = aws_instance.salon-dev.public_ip
    BE_API         = data.aws_eip.shared_eip.public_ip
    BASEPATH       = ""
    BASE_HOST_PATH = "/api/apps"
    API_URL        = "${aws_instance.salon-dev.public_ip}:3000"
  })
  filename = "${path.module}/upload-files/dev.env"
}

# Handle all provisioning in a null resource
resource "null_resource" "setup_instance" {
  depends_on = [aws_instance.salon-dev, local_file.env_file]

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
