resource "aws_instance" "frontend_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.app_sg.name]
  iam_instance_profile = aws_iam_instance_profile.fe_instance_profile.name

  user_data = templatefile("cloud-init-frontend.tpl", {
    api_ip                  = "${aws_instance.backend_instance.public_ip}",
    codeartifact_domain     = "${var.codeartifact_domain}",
    codeartifact_repository = "${var.codeartifact_repository}",
    codeartifact_region     = "${var.codeartifact_region}"
    },
  )

  tags = {
    Name = var.frontend_name_tag
  }
}

resource "aws_iam_instance_profile" "fe_instance_profile" {
  name = "FrontendInstanceProfile"
  role = aws_iam_role.codeartifact_role.name
}