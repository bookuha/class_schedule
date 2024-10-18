resource "aws_instance" "cloudwatch_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.app_sg.name, aws_security_group.cloudwatch_sg.name]
  iam_instance_profile = aws_iam_instance_profile.cloudwatch_profile.name
  key_name             = aws_key_pair.ssh-key.key_name

  tags = {
    Name = var.cloudwatch_name_tag
    Role = var.cloudwatch_exporter_role_tag
  }
}

resource "aws_security_group" "cloudwatch_sg" {
  name        = "cloudwatch_sg"
  description = "Allow access to CloudWatch Exporter"

  ingress {
    from_port   = 9106  # Port used by CloudWatch Exporter
    to_port     = 9106
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_instance_profile" "cloudwatch_profile" {
  name = "cloudwatch_profile"
  role = aws_iam_role.cloudwatch_role.name
}

