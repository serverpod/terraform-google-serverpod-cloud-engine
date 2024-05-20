locals {
  gcp_service_list = [
    "artifactregistry.googleapis.com",
    "certificatemanager.googleapis.com",
    "dns.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "sqladmin.googleapis.com",
    "redis.googleapis.com",
  ]
}

resource "google_project_service" "gcp_services" {
  count              = length(local.gcp_service_list)
  project            = var.project
  service            = local.gcp_service_list[count.index]
  disable_on_destroy = false
}
