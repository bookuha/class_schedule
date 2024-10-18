variable "ami" {
  type        = string
  description = "Amazon Linux AMI"
  default     = "ami-0129bfde49ddb0ed6"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
  default     = "t3.micro"
}

variable "frontend_name_tag" {
  type        = string
  description = "Name of the EC2 Frontend Instance"
  default     = "cs_fe"
}

variable "backend_name_tag" {
  type        = string
  description = "Name of the EC2 Backend Instance"
  default     = "cs_be"
}

variable "prometheus_name_tag" {
  type        = string
  description = "Name of the EC2 Prometheus Instance"
  default     = "cs_prom"
}

variable "grafana_name_tag" {
  type        = string
  description = "Name of the EC2 Grafana Instance"
  default     = "cs_graf"
}

variable "cloudwatch_name_tag" {
  type        = string
  description = "Name of the EC2 CloudWatch Exporter Instance"
  default     = "cs_cwatch"
}

variable "mongo_name_tag" {
  type        = string
  description = "Name of the EC2 Mongo Instance"
  default     = "cs_mongo"
}

variable "node_exporter_role_tag" {
  type        = string
  description = "Role tag for instances that have Node Exporter set up on them. Required for dynamic discovery of such services by Prometheus."
  default     = "node-exporter"
}

variable "nginx_exporter_role_tag" {
  type        = string
  description = "Role tag for instances that have Nginx Exporter set up on them. Required for dynamic discovery of such services by Prometheus."
  default     = "nginx-exporter"
}

variable "cloudwatch_exporter_role_tag" {
  type        = string
  description = "Role tag for instances that have CloudWatch Exporter set up on them. Required for dynamic discovery of such services by Prometheus."
  default     = "cloudwatch-exporter"
}

variable "mongo_cluster_identifier" {
  type        = string
  description = "Mongo Cluster Identifier"
  default     = "mongo-cluster"
}

variable "mongo_instance_identifier" {
  type        = string
  description = "Mongo Instance Identifier"
  default     = "mongo-instance"
}

variable "mongo_instance_class" {
  type        = string
  description = "Mongo Instance Class"
  default     = "db.t3.medium"
}

variable "mongo_master_username" {
  type        = string
  description = "Mongo Master Username"
  sensitive   = true
}

variable "mongo_master_password" {
  type        = string
  description = "Mongo Master Password"
  sensitive   = true
}

variable "redis_node_type" {
  type        = string
  description = "Redis Node Type"
  default     = "cache.t3.micro"
}

variable "postgres_instance_class" {
  type        = string
  description = "Postgres Instance Class"
  default     = "db.t3.micro"
}

variable "postgres_name" {
  type        = string
  description = "Postgres DB Name"
  default     = "class_schedule"
}

variable "postgres_username" {
  type        = string
  description = "Postgres DB Username"
  sensitive   = true
}

variable "postgres_password" {
  type        = string
  description = "Postgres DB Password"
  sensitive   = true
}

variable "mongo_current_db" {
  type        = string
  description = "Current DB Name"
  default     = "class_schedule"
}

variable "aws_access_key_id" {
  type        = string
  description = "AWS Access Key Id"
  sensitive   = true
}

variable "aws_secret_access_key" {
  type        = string
  description = "AWS Secret Access Key"
  sensitive   = true
}