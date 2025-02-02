resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.proxy.id
  allocation_id = data.terraform_remote_state.proxy_eip.outputs.eip_proxy_public_id
}
