resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-cluster"
  engine               = "redis"
  node_type            = var.redis_node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = 6379
  security_group_ids   = [aws_security_group.redis_sg.id]
}

resource "aws_security_group" "redis_sg" {
  name        = "redis-security-group"
  description = "Allow backend to access Redis"
  tags = {
    Name = "redis-security-group"
  }
}

resource "aws_security_group_rule" "redis_to_be" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.redis_sg.id
  source_security_group_id = aws_security_group.be_sg.id
}