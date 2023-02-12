variable "token" {
  sensitive = true # Requires terraform >= 0.14
  default   = ""
}

provider "hcloud" {
  token = var.token
}

resource "hcloud_ssh_key" "default" {
  name       = "default ssh key"
  public_key = file("~/.ssh/hetzner_ed.pub")
}

resource "hcloud_server" "test" {
  name        = "node1"
  image       = "fedora-37"
  server_type = "cx11"
  ssh_keys    = [hcloud_ssh_key.default.name]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

output "ipv4" {
  value = hcloud_server.test.ipv4_address
}
