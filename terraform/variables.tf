variable "bucket" {
  description = "HCP Packer Bucket"
}

variable "channel" {
  description = "HCP Packer Channel"
}

variable "region" {
  description = "region where to operate"
  default = "europe-west1-c"
}

variable "region_zone" {
  description = "GCP zone targeted"
  default = "europe-west1-c"
}

variable "project" {
  description = "project where to operate"
  default = "sb-vault"
}

variable "instance_type" {
  description = "GCP Machine Type to use"
  default = "f1-micro"
}

variable "ssh_user" {
  description = "instance SSH user"
  default = "sebastien"
}

variable "ssh_pub_key" {
  description = "SSH public key to authorize"
}
