terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.25.0"
    }
  }
}

resource "google_compute_instance" "nagios_vm_instance" {
  name         = "nagios-instance"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = var.vm_image
      size = 40
    }
  }

  network_interface {
    network = "default"
  }
  #Allow http traffic
  tags = ["http-server"]
}