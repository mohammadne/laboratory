terraform {
  required_version = ">= 0.13"

  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}
