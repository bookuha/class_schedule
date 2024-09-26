resource "docker_image" "frontend" {
    name = var.frontend_image
}

resource "docker_container" "frontend" {
    name = "frontend"
    image = docker_image.frontend.image_id
    networks_advanced {
        name = docker_network.app_network.name
    }
    ports {
        internal = 3000
        external = 3000
    }
    env = [
        "REACT_APP_API_BASE_URL=${var.frontend_api_url}"
    ]
}