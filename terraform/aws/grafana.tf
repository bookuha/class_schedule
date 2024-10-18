resource "aws_instance" "grafana_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.app_sg.name, aws_security_group.grafana_sg.name]
  key_name             = aws_key_pair.ssh-key.key_name

  tags = {
    Name = var.grafana_name_tag
  }
}

resource "aws_security_group" "grafana_sg" {
  name        = "cs_grafana_sg"
  description = "Allow inbound traffic for Grafana"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}