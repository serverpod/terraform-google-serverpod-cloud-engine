# Storage bucket for public files.

resource "google_storage_bucket" "public" {
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

resource "google_storage_bucket_access_control" "public" {
  bucket = google_storage_bucket.public.id
  role   = "READER"
  entity = "allUsers"
}

# Storage bucket for private files.

resource "google_storage_bucket" "private" {
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