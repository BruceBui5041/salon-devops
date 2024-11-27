resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS key pair
resource "aws_key_pair" "generated_key" {
  key_name   = "db-dev-key"
  public_key = tls_private_key.ssh_key.public_key_openssh


  # Save public key
  provisioner "local-exec" {
    command = "echo '${tls_private_key.ssh_key.public_key_openssh}' > db-dev-key.pub"
  }

  # Save private key
  provisioner "local-exec" {
    command = "echo '${tls_private_key.ssh_key.private_key_pem}' > db-dev-key.pem"
  }

  # Set permissions on private key
  provisioner "local-exec" {
    command = "chmod 400 db-dev-key.pem"
  }
}
