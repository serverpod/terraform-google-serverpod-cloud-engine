# Firewall rules.

resource "google_compute_firewall" "serverpod-instance" {
  name = "serverpod-${var.runmode}-instance"

  network       = google_compute_network.serverpod.name
  source_ranges = ["0.0.0.0/0"]

  # allow {
  #   protocol = "icmp"
  # }

  allow {
    protocol = "tcp"
    ports    = ["8080-8082"]
  }

  target_tags = ["serverpod-${var.runmode}-instance"]
}

resource "google_compute_firewall" "serverpod-instance-ssh" {
  count = var.enable_ssh ? 1 : 0

  name = "serverpod-${var.runmode}-instance-ssh"

  network       = google_compute_network.serverpod.name
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["serverpod-${var.runmode}-instance-ssh"]
}
