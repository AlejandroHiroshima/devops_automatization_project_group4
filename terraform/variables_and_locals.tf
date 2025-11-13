variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "swedencentral"
}

variable "prefix_app_name" {
  description = "Name prefix for resources"
  type        = string
  default     = "AH_DevOps_Pipeline"
}

variable "owner" {
  description = "Name of owner"
  type        = string
  default     = "Alexander Hrachovina"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "80f1ebe5-8470-4115-8204-ba8fdcc457fc"

}

resource "random_string" "suffix" {
  length  = 3
  special = false
  upper   = false
}

locals {
  common_tags = {
    owner = var.owner
  }
}

variable "docker_repo" {
    description = "name of docker repo"
    type = string
    default = "alejandrohiroshima/alejandro:"
}

variable "docker_tag" {
    description = "image tag to deploy"
    type = string
    default = "latest"
}

variable "docker_url" {
    description = "URL for docker hub"
    type = string
    default = "https://index.docker.io"
}
