resource "aws_instance" "backend_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.app_sg.name]

  user_data = templatefile("cloud-init-backend.tpl", {
    db_host = "${aws_db_instance.postgres.address}",
    db_port = "${aws_db_instance.postgres.port}",
    db_user = "${aws_db_instance.postgres.username}",
    db_password = "${aws_db_instance.postgres.password}",
    db_name = "${aws_db_instance.postgres.db_name}",
    redis_host = "${aws_elasticache_cluster.redis.cache_nodes[0].address}",
    redis_port = "${aws_elasticache_cluster.redis.port}",
    mongo_current_db = "${var.mongo_current_db}",
    mongo_default_server_cluster = "${aws_instance.mongo_instance.public_ip}"
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