resource "docker_image" "backend" {
    name = var.backend_image
}

resource "docker_container" "backend" {
    name = "backend"
    image = docker_image.backend.image_id
    networks_advanced {
        name = docker_network.app_network.name
    }
    ports {
        internal = 8080
        external = 8080
    }
    env = [
        "DB_HOST=${var.postgres_host}",
        "DB_PORT=${var.postgres_port}",
        "DB_NAME=${var.postgres_db}",
        "DB_USER=${var.postgres_user}",
        "DB_PASSWORD=${var.postgres_password}",
        "REDIS_HOST=${var.redis_host}",
        "REDIS_PORT=${var.redis_port}",
        "MONGO_CURRENT_DB=${var.mongo_database}",
        "MONGO_DEFAULT_SERVER_CLUSTER=${var.mongo_default_server_cluster}"
    ]
    depends_on = [
        docker_container.postgres,
        docker_container.redis,
        docker_container.mongo
    ]
}