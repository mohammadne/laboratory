variable "nginx_version" {
  type        = string
  description = "value of the nginx contaner tag"
  default     = "docker_image.nginx.latest"
}

variable "ngins_image_version" {
  type        = string
  description = "value of nginex version"
  default     = "nginx:latest"
}

variable "container_name" {
  type        = string
  description = "value of the container name"
  default     = "nginx"
}

variable "container_host_name" {
  type        = string
  description = "value of the hostname of the contianer"
  default     = "nginx"
}

variable "internal_container_port" {
  type        = number
  description = "value of the internal container port"
  default     = 80
}

variable "external_container_port" {
  type        = number
  description = "value of the External container port"
  default     = 8000
}

variable "keep_locally" {
  type        = bool
  description = "If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation."
  default     = false
}

variable "force_remove" {
  type        = bool
  description = "If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation."
  default     = true
}

variable "container_path" {
  type        = string
  description = "value of the container volumes path"
  default     = "/usr/share/nginx/html"
}

variable "host_path" {
  type        = string
  description = "value of the host_path path"
  default     = "/Users/mohammad/Develop/laboratory/terraform/docker/data"
}

variable "read_only" {
  type        = bool
  description = "If true, this volume will be readonly. Defaults to false"
  default     = false
}

variable "container_restart" {
  type        = string
  description = "The restart policy for the container. Must be one of 'no', 'on-failure', 'always', 'unless-stopped'. Defaults to no."
  default     = "always"
}

variable "container_network" {
  type = object({
    name   = string
    driver = string
  })
  default = {
    name   = "nginx_network"
    driver = "bridge"
  }
}
