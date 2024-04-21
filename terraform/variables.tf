variable "project" {
  description = "The GCP project to deploy resources to"
  default = "Nagios Project"
  type = string
}

variable "region" {
  description = "The GCP region to deploy resources to"
  default = "us-central1"
  type = string
}

variable "zone" {
  description = "The GCP zone to deploy resources to"
  default = "us-central1-a"
  type = string
}

variable "vm_image" {
  description = "The VM image to use for the VM instance"
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
  type = string
}