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

variable "mongo_name_tag" {
  type        = string
  description = "Name of the EC2 Mongo Instance"
  default     = "cs_mongo"
} 

variable "redis_node_type" {
  type = string
  description = "Redis Node Type"
  default = "cache.t3.micro"
}

variable "postgres_instance_class" {
  type = string
  description = "Postgres Instance Class"
  default = "db.t3.micro"
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

variable "codeartifact_domain" {
  type        = string
  description = "AWS CodeArtifact Domain"
}

variable "codeartifact_repository" {
  type        = string
  description = "AWS CodeArtifact Resository"
}

variable "codeartifact_region" {
  type        = string
  description = "AWS CodeArtifact Region"
}