terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.25.0"
    }
  }
}

resource "google_service_account" "default" {
  account_id   = "my-custom-sa"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "nagios_vm_instance" {
  name         = "nagios-instance"
  machine_type = "e2-medium"
  tags = ["nagios"]

  boot_disk {
    initialize_params {
      image = var.vm_image
      size = 40
    }
  }

  network_interface {
    network = "default"
  }
}