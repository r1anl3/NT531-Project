provider "google" {
  # Configuration options
  credentials = file("key.json")
  project = "Nagios Project"
  region = "us-central1"
}