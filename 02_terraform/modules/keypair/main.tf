resource "aws_key_pair" "project_03_keypair" {
  key_name   = var.key_name
  public_key = tls_private_key.project_03_tls.public_key_openssh
}

resource "tls_private_key" "project_03_tls" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "project_03_local" {
  filename        = var.filename
  content         = tls_private_key.project_03_tls.private_key_pem
  file_permission = "0400"
}

