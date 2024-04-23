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

  #Create boot disk
  boot_disk {
    initialize_params {
      image = var.vm_image
      size = 40
    }
  }

  #Create network interface
  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  #Allow http traffic
  tags = ["http-server"]

  #Update instance status
  desired_status = "RUNNING"
}

resource "google_compute_instance" "nginx_vm_instance" {
  name         = "nginx-instance"
  machine_type = "e2-medium"

  #Create boot disk
  boot_disk {
    initialize_params {
      image = var.vm_image
      size = 40
    }
  }

  #Create network interface
  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  #Allow http traffic
  tags = ["http-server"]

  #Update instance status
  desired_status = "TERMINATED"
}