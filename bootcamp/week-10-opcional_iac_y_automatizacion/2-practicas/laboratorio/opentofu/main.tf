# La app de referencia descrita como infraestructura con OpenTofu.
# El "proveedor de nube" es el Docker de tu equipo: gratis y sin cuentas. Con otro proveedor
# (Render, un hipervisor, una nube) cambian los recursos, no el ciclo init/plan/apply/destroy.

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.6"
    }
  }
}

provider "docker" {}   # usa el Docker local (/var/run/docker.sock)

variable "app_version" {
  description = "Versión de la imagen biblioteca a desplegar (debe existir en el equipo)"
  type        = string
  default     = "1.0.0"
}

variable "puerto" {
  description = "Puerto de tu equipo donde queda la app"
  type        = number
  default     = 8100
}

variable "postgres_password" {
  description = "Contraseña de la base: llega por TF_VAR_postgres_password, nunca en un archivo"
  type        = string
  sensitive   = true
}

resource "docker_network" "red" {
  name = "biblioteca-tofu"
}

resource "docker_volume" "datos" {
  name = "biblioteca-tofu-datos"
}

resource "docker_image" "postgres" {
  name         = "postgres:17-alpine"
  keep_locally = true
}

resource "docker_container" "db" {
  name    = "biblioteca-tofu-db"
  image   = docker_image.postgres.image_id
  restart = "unless-stopped"
  env = [
    "POSTGRES_USER=biblioteca",
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "POSTGRES_DB=biblioteca",
  ]
  networks_advanced {
    name    = docker_network.red.name
    aliases = ["db"]
  }
  volumes {
    volume_name    = docker_volume.datos.name
    container_path = "/var/lib/postgresql/data"
  }
  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -U biblioteca -d biblioteca"]
    interval = "5s"
    retries  = 10
  }
  wait = true   # no se da por creado hasta que su healthcheck pase
}

resource "docker_container" "app" {
  name    = "biblioteca-tofu-app"
  image   = "biblioteca:${var.app_version}"
  restart = "unless-stopped"
  env     = ["DATABASE_URL=postgresql://biblioteca:${var.postgres_password}@db:5432/biblioteca"]
  networks_advanced {
    name = docker_network.red.name
  }
  ports {
    internal = 8000
    external = var.puerto
    ip       = "127.0.0.1"
  }
  wait       = true
  depends_on = [docker_container.db]
}

output "url" {
  value = "http://localhost:${var.puerto}"
}
