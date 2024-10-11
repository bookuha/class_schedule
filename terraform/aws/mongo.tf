resource "aws_instance" "mongo_instance" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.app_sg.name]
  key_name        = aws_key_pair.ssh-key.key_name

  user_data = file("cloud-init-mongo.yaml") # Path to your cloud-init for MongoDB

  tags = {
    Name = var.mongo_name_tag
  }
}