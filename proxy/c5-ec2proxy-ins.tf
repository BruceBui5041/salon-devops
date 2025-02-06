resource "aws_instance" "proxy" {
  ami           = "ami-0c802847a7dd848c0"
  key_name      = aws_key_pair.generated_key.key_name
  instance_type = var.proxy_ins_type
  subnet_id     = data.terraform_remote_state.network.outputs.aws_subnet_public_id

  vpc_security_group_ids = [aws_security_group.proxy_sg.id]

  # Upload the installation script
  user_data = base64encode(templatefile("${path.module}/scripts/install_nginx.sh", {
    backend_private_ip = module.common_vars.backend_private_ip
    db_private_ip      = module.common_vars.db_private_ip
  }))

  tags = {
    Name = "proxy-instance"
  }
}

# resource "null_resource" "setup_instance" {
#   depends_on = [aws_eip_association.eip_assoc]
#   provisioner "file" {
#     source      = "${path.module}/scripts/install_nginx.sh"
#     destination = "/tmp/install_nginx.sh"

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = tls_private_key.ssh_key.private_key_pem
#       host        = aws_instance.proxy.public_ip
#       timeout     = "4m"
#     }
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/install_nginx.sh",
#       "sudo /tmp/install_nginx.sh --backend-ip ${module.common_vars.backend_private_ip} --db-ip ${module.common_vars.db_private_ip}"
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = tls_private_key.ssh_key.private_key_pem
#       host        = aws_instance.proxy.public_ip
#       timeout     = "4m"
#     }
#   }
# }
