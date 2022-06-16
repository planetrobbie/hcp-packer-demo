terraform {
  required_providers {
    hcp = {
      source = "hashicorp/hcp"
      version = "~> 0.17.0"
    }
  }
}

provider "google" {
  region      = var.region
  project     = var.project
}

data "hcp_packer_iteration" "vault" {
	bucket_name = var.bucket
	channel = var.channel
}

data "hcp_packer_image" "vault-image" {
	bucket_name = var.bucket
	iteration_id = data.hcp_packer_iteration.vault.ulid
	cloud_provider = "gce"
	region = var.region
}

resource "google_compute_instance" "vm" {
  name         = "vault-vm"
  machine_type = var.instance_type
  zone         = var.region_zone
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = data.hcp_packer_image.vault-image.cloud_image_id
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
  metadata = {
    sshKeys = "var.ssh_user:var.ssh_pub_key"
  }
}

output "vault-production-image-id" {
	value = data.hcp_packer_image.vault-image.cloud_image_id
}
