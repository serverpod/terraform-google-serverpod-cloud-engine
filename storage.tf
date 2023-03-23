# Storage bucket for public files.

resource "google_storage_bucket" "public" {
  count = var.enable_storage ? 1 : 0

  name                        = "${var.subdomain_prefix}storage.${var.top_domain}"
  location                    = var.storage_bucket_location
  storage_class               = var.storage_bucket_class
  uniform_bucket_level_access = false

  force_destroy = true

  cors {
    origin          = ["*"]
    method          = ["*"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

# Allow access to the public bucket.

resource "google_storage_bucket_iam_member" "public" {
  count = var.enable_storage ? 1 : 0

  bucket = google_storage_bucket.public[0].name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Storage bucket for private files.

resource "google_storage_bucket" "private" {
  count = var.enable_storage ? 1 : 0

  name                        = "${var.subdomain_prefix}private-storage.${var.top_domain}"
  location                    = var.storage_bucket_location
  storage_class               = var.storage_bucket_class
  uniform_bucket_level_access = false

  force_destroy = true

  cors {
    origin          = ["*"]
    method          = ["*"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}