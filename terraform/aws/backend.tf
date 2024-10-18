resource "aws_instance" "backend_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.app_sg.name, aws_security_group.be_sg.name]
  iam_instance_profile = aws_iam_instance_profile.be_instance_profile.name
  key_name             = aws_key_pair.ssh-key.key_name

  tags = {
    Name = var.backend_name_tag
    Role = var.node_exporter_role_tag
  }

  depends_on = [
    aws_db_instance.postgres,
    aws_elasticache_cluster.redis,
    aws_docdb_cluster.mongo_cluster
  ]
}

resource "aws_iam_instance_profile" "be_instance_profile" {
  name = "BackendInstanceProfile"
  role = aws_iam_role.codeartifact_role.name
}

resource "aws_security_group" "be_sg" {
  name        = "be-security-group"
  description = "Allow backend to access storages"
  tags = {
    Name = "backend-security-group"
  }
}

resource "aws_security_group_rule" "be_to_db" {
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.be_sg.id
  source_security_group_id = aws_security_group.db_sg.id
}

resource "aws_security_group_rule" "be_to_mongo" {
  type                     = "egress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = aws_security_group.be_sg.id
  cidr_blocks              = ["0.0.0.0/0"] # TODO: Cross-Region VPC Peering / Correct CIDR
}

resource "aws_security_group_rule" "be_to_redis" {
  type                     = "egress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.be_sg.id
  source_security_group_id = aws_security_group.redis_sg.id
}

