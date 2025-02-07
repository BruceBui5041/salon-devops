resource "aws_instance" "proxy" {
  ami           = "ami-0c802847a7dd848c0"
  key_name      = aws_key_pair.generated_key.key_name
  instance_type = var.proxy_ins_type
  subnet_id     = data.terraform_remote_state.network.outputs.aws_subnet_public_id

  vpc_security_group_ids = [aws_security_group.proxy_sg.id]

  # Upload the installation script
  user_data = base64encode(templatefile("${path.module}/scripts/install_nginx.sh", {
    backend_private_ip     = module.common_vars.backend_private_ip
    db_private_ip          = module.common_vars.db_private_ip
    admin_panel_private_ip = module.common_vars.admin_panel_private_ip
  }))

  tags = {
    Name = "proxy-instance"
  }
}
