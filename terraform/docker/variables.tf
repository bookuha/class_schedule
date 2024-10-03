variable "postgres_host" {}
variable "postgres_port" {}
variable "postgres_db" {}
variable "postgres_user" {}
variable "postgres_password" {}
variable "mongo_database" {}
variable "mongo_default_server_cluster" {}
variable "redis_host" {}
variable "redis_port" {}
variable "redis_external_port" {}
variable "frontend_api_url" {}
variable "backend_image" {
  default = "bookuha/class_schedule_backend:neo"
}
variable "frontend_image" {
  default = "bookuha/class_schedule_frontend:neo"
}