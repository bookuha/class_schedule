# Output for the frontend EC2 instance
output "frontend_instance_public_ip" {
  description = "Public IP address of the frontend EC2 instance"
  value       = aws_instance.frontend_instance.public_ip
}

# Output for the backend EC2 instance
output "backend_instance_public_ip" {
  description = "Public IP address of the backend EC2 instance"
  value       = aws_instance.backend_instance.public_ip
}

# Output for MongoDB DocumentDB Cluster Endpoint
output "mongo_instance_public_ip" {
  description = "Endpoint of the MongoDB DocumentDB cluster"
  value       = aws_docdb_cluster.mongo_cluster.endpoint
}

# Output for Postgres instance public IP
output "postgres_instance_public_ip" {
  description = "Public IP address of the RDS instance"
  value       = aws_db_instance.postgres.address
}

# Output for Redis instance public IP
output "redis_instance_public_ip" {
  description = "Public IP address of the ElastiCache Redis instance"
  value       = aws_elasticache_cluster.redis.cache_nodes[0].address
}

# Output for Prometheus instance public IP
output "prometheus_instance_public_ip" {
  description = "Public IP address of the Prometheus instance"
  value       = aws_instance.prometheus_instance.public_ip
}

# Output for Grafana instance public IP
output "grafana_instance_public_ip" {
  description = "Public IP address of the Grafana instance"
  value       = aws_instance.grafana_instance.public_ip
}

# Output for Cloudwatch instance public IP
output "cloudwatch_instance_public_ip" {
  description = "Public IP address of the CloudWatch Exporter instance"
  value       = aws_instance.cloudwatch_instance.public_ip
}