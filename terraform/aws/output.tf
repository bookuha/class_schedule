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

# Output for MongoDB instance public IP
output "mongo_instance_public_ip" {
  description = "Public IP address of the MongoDB EC2 instance"
  value       = aws_instance.mongo_instance.public_ip
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