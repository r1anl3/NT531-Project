provider "google" {
  # Configuration options
  project = var.project
  region = var.region
  zone = var.zone
  credentials = file("key.json")
}