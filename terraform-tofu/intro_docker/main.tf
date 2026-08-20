terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.2.0"
    }
  }
}


provider "docker" {
}


resource "docker_image" "caddy" {
  name         = "caddy:alpine"
  keep_locally = false
}

resource "docker_container" "caddy" {
  image = docker_image.caddy.image_id
  name  = var.container_name

  ports {
    internal = 80
    external = 30080
  }
}


output "container_id" {
  value = docker_container.caddy.id
}
output "image_id" {
  value = docker_image.caddy.id
}
