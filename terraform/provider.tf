terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.25.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = var.project
  region = var.region
  zone = var.zone
  credentials = file("key.json")
}