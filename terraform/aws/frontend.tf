resource "aws_instance" "frontend_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.app_sg.name]
  iam_instance_profile = aws_iam_instance_profile.fe_instance_profile.name
  key_name             = aws_key_pair.key_name

  tags = {
    Name = var.frontend_name_tag
  }
}

resource "aws_iam_instance_profile" "fe_instance_profile" {
  name = "FrontendInstanceProfile"
  role = aws_iam_role.codeartifact_role.name
}