output "network" {
  description = "The name of Serverpod's private network."
  value       = google_compute_network.serverpod.name
}

output "artifact_registry_id" {
  description = "The ID of Serverpod's Artifact Registry."
  value       = google_artifact_registry_repository.containers.id
}
