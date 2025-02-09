resource "aws_eip_association" "eip_assoc" {
  depends_on    = [aws_spot_instance_request.proxy]
  instance_id   = aws_spot_instance_request.proxy.spot_instance_id
  allocation_id = data.terraform_remote_state.proxy_eip.outputs.eip_proxy_public_id
}

# null resource to handle EIP association
resource "null_resource" "eip_assoc_handler" {
  triggers = {
    spot_request_id = aws_spot_instance_request.proxy.id
    instance_id     = aws_spot_instance_request.proxy.spot_instance_id
    # Track the instance state
    instance_state = aws_spot_instance_request.proxy.instance_state
  }

  provisioner "local-exec" {
    command = <<-EOF
      aws ec2 associate-address \
        --instance-id ${aws_spot_instance_request.proxy.spot_instance_id} \
        --allocation-id ${data.terraform_remote_state.proxy_eip.outputs.eip_proxy_public_id} \
        --region ${var.aws_region}
    EOF
  }
}
