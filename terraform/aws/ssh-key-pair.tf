resource "aws_key_pair" "ssh-key" {
  key_name   = "host-ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}