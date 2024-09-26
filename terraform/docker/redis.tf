resource "docker_image" "redis" {
    name = "redis:latest"
}

resource "docker_container" "redis" {
    name = "redis"
    image = docker_image.redis.image_id
    networks_advanced {
        name = docker_network.app_network.name
    }
    ports {
        internal = var.redis_port
        external = var.redis_external_port
    }
}