resource "aws_instance" "project_03" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = ["${var.security_group_name}"]
  associate_public_ip_address = true
  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.username
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
    scripts = ["./scripts/${var.script_name}"]

  }

  provisioner "local-exec" {
    command = "echo -e 'instance_ip: ${self.public_ip}' >> ip_address.txt"
  }

}
