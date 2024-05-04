variable "project" {
  description = "The GCP project to deploy resources to"
  default = ""
  type = string
}

variable "region" {
  description = "The GCP region to deploy resources to"
  default = ""
  type = string
}

variable "zone" {
  description = "The GCP zone to deploy resources to"
  default = ""
  type = string
}

variable "vm_image" {
  description = "The VM image to use for the VM instance"
  default = ""
  type = string
}