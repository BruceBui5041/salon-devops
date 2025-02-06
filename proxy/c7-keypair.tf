resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS key pair
resource "aws_key_pair" "generated_key" {
  key_name   = "proxy-dev-key"
  public_key = tls_private_key.ssh_key.public_key_openssh


  # Save public key
  provisioner "local-exec" {
    command = "printf '%s' '${tls_private_key.ssh_key.public_key_openssh}' > private-key/proxy-dev-key.pub"
  }

  # Save private key (overwrite)
  provisioner "local-exec" {
    command = "printf '%s' '${tls_private_key.ssh_key.private_key_pem}' > private-key/proxy-dev-key.pem"
  }

  # Set permissions on private key
  provisioner "local-exec" {
    command = "chmod 700 private-key/proxy-dev-key.pem && chmod 700 private-key/proxy-dev-key.pub"
  }
}
