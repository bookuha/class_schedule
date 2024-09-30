resource "aws_instance" "frontend_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.app_sg.name]

  user_data = templatefile("cloud-init-frontend.tpl", {api_ip = "${aws_instance.backend_instance.public_ip}"})

  tags = {
    Name = var.frontend_name_tag
  }
}