# require specific plugin version to support HCP Packer
packer {
  required_version = ">= 1.7.7"
  required_plugins {
    googlecompute = {
      version = ">= 1.0.5"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

variable "project_id" {
  type    = string
  default = "hc-5b7fed7760b3436abf1b70b347b"
}

variable "zone" {
  type    = string
  default = "europe-west1-c"
}

source "googlecompute" "vault" {
  image_family        = "vault"
  image_name          = "ubuntu-vault-${legacy_isotime("2006-01-02-030405")}"
  project_id          = "${var.project_id}"
  source_image_family = "ubuntu-2210-amd64"
  ssh_username        = "ubuntu"
  zone                = "${var.zone}"
}

build {
  sources = ["source.googlecompute.vault"]

  hcp_packer_registry {
    bucket_name = "vault"
    description = <<EOT
This image built on top of Ubuntu Minimal 2110 contains Vault binary 
    EOT
    bucket_labels = {
      "target-use"  = "vault",
    }
  }

  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    script          = "./files/script.sh"
  }
}
