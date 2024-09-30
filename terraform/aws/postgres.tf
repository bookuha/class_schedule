resource "aws_db_instance" "postgres" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "16.3"
  instance_class       = "db.t3.micro"
  db_name              = var.postgres_name
  username             = var.postgres_username
  password             = var.postgres_password
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true
}