resource "aws_instance" "monitoring_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.app_sg.name, aws_security_group.monitoring_sg.name]
  key_name             = aws_key_pair.ssh-key.key_name

  tags = {
    Name = var.monitoring_name_tag
  }
}

resource "aws_security_group" "monitoring_sg" {
  name        = "cs_monitoring_sg"
  description = "Allow inbound traffic for Prometheus"

  ingress {
    from_port   = 9090
    to_port     = 9090
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