output "network" {
  description = "The name of Serverpod's private network."
  value       = google_compute_network.serverpod.name
}
