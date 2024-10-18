resource "aws_instance" "prometheus_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.app_sg.name, aws_security_group.prometheus_sg.name]
  iam_instance_profile = aws_iam_instance_profile.prometheus_instance_profile.name
  key_name             = aws_key_pair.ssh-key.key_name

  tags = {
    Name = var.prometheus_name_tag
  }
}

resource "aws_security_group" "prometheus_sg" {
  name        = "cs_prometheus_sg"
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