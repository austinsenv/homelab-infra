# Debian 12 VM with cloud-init

terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "debian-vm" {
  name        = "debian-vm"
  target_node = var.pm_target_node
  clone       = "template-vm01"
  full_clone  = true
  cores       = 4
  memory      = 8192

  disk {
    slot     = 0
    size     = "32G"
    type     = "scsi"
    storage  = "local-lvm"
    discard  = true
  }

  network {
    id        = 0
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = false
    link_down = false
  }
}
