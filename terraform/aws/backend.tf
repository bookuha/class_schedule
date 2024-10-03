resource "aws_instance" "backend_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.app_sg.name, aws_security_group.be_sg.name]
  iam_instance_profile = aws_iam_instance_profile.be_instance_profile.name

  user_data = templatefile("cloud-init-backend.tpl", {
    db_host                      = "${aws_db_instance.postgres.address}",
    db_port                      = "${aws_db_instance.postgres.port}",
    db_user                      = "${aws_db_instance.postgres.username}",
    db_password                  = "${aws_db_instance.postgres.password}",
    db_name                      = "${aws_db_instance.postgres.db_name}",
    redis_host                   = "${aws_elasticache_cluster.redis.cache_nodes[0].address}",
    redis_port                   = "${aws_elasticache_cluster.redis.port}",
    mongo_current_db             = "${var.mongo_current_db}",
    mongo_default_server_cluster = "${aws_instance.mongo_instance.public_ip}",
    codeartifact_domain          = "${var.codeartifact_domain}",
    codeartifact_repository      = "${var.codeartifact_repository}",
    codeartifact_region          = "${var.codeartifact_region}"
    },
  )

  tags = {
    Name = var.backend_name_tag
  }

  depends_on = [
    aws_db_instance.postgres,
    aws_elasticache_cluster.redis,
    aws_instance.mongo_instance
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

resource "aws_security_group_rule" "be_to_redis" {
  type                     = "egress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.be_sg.id
  source_security_group_id = aws_security_group.redis_sg.id
}

