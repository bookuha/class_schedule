resource "docker_image" "mongo" {
  name = "mongo:latest"
}

resource "docker_container" "mongo" {
  name  = "mongo"
  image = docker_image.mongo.image_id
  networks_advanced {
    name = docker_network.app_network.name
  }
  env = [
    "MONGO_INITDB_DATABASE=${var.mongo_database}"
  ]
}