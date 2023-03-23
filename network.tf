# Private network.

resource "google_compute_network" "serverpod" {
  name = "serverpod-${var.runmode}-network"
}

resource "google_compute_global_address" "private-ip" {
  name          = "serverpod-${var.runmode}-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.serverpod.id
}

resource "google_service_networking_connection" "private-vpc-connection" {
  network                 = google_compute_network.serverpod.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private-ip.name]
}