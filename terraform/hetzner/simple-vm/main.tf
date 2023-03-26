resource "hcloud_ssh_key" "default" {
  name       = "default ssh key"
  public_key = file("~/.ssh/hetzner_ed25519.pub")
}

# setup the VM
resource "hcloud_server" "vpn" {
  name        = "vpn"
  image       = var.os_type
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.default.id]
}


output "web_server_status" {
  value = hcloud_server.web.status
}

output "web_server_ip" {
  value = hcloud_server.web.ipv4_address
}
