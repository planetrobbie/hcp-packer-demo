terraform {
  required_providers {
    hcp = {
      source = "hashicorp/hcp"
      version = "~> 0.17.0"
    }
  }
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

resource "null_resource" "touch" {
  triggers = {
    please_redo = "1"
  }
}

output "vault-production-image-id" {
	value = data.hcp_packer_image.vault-image.cloud_image_id
}