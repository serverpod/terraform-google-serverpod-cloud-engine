# Artifact registry, where we store your Docker images.

resource "google_artifact_registry_repository" "containers" {
  location      = var.region
  repository_id = "serverpod-${var.runmode}-container"
  format        = "DOCKER"
}
