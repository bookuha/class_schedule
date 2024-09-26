resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "nginx_container"
  image = docker_image.nginx.image_id
  networks_advanced {
      name = docker_network.app_network.name
  }
  ports {
    internal = 80
    external = 80
  }
  volumes {
    host_path      = "C:\\repos\\class_schedule\\terraform\\docker\\nginx.conf"
    container_path = "/etc/nginx/nginx.conf"       
  }

}