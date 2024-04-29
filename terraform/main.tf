
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
  tags = ["http-server", "influx", "grafana"]

  #Update instance status
  desired_status = "TERMINATED"
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
  tags = ["http-server", "nginx"]

  #Update instance status
  desired_status = "TERMINATED"
}

resource "google_compute_firewall" "influxdb_firewall" {
  project     = var.project
  name        = "influxdb-firewall-rule"
  network     = "default"
  description = "Create a firewall rule to allow influxdb traffic"

  allow {
    protocol  = "tcp"
    ports     = ["8086"]
  }

  target_tags = ["influx"]
}

resource "google_compute_firewall" "grafana_firewall" {
  project     = var.project
  name        = "grafana-firewall-rule"
  network     = "default"
  description = "Create a firewall rule to allow grafana"

  allow {
    protocol  = "tcp"
    ports     = ["3000"]
  }

  target_tags = ["grafana"]
}

resource "google_compute_firewall" "nginx_firewall" {
  project     = var.project
  name        = "nginx-firewall-rule"
  network     = "default"
  description = "Create a firewall rule to allow nginx"

  allow {
    protocol  = "tcp"
    ports     = ["8080"]
  }

  target_tags = ["nginx"]
}