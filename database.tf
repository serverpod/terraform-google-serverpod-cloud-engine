# Postgres database.

resource "google_sql_database_instance" "serverpod" {
  name             = "serverpod-${var.runmode}-database"
  database_version = var.database_version
  region           = var.region

  settings {
    tier              = var.database_tier
    availability_type = var.database_availability_type

    backup_configuration {
      enabled                        = var.database_backup_enabled
      point_in_time_recovery_enabled = var.database_backup_point_in_time_recovery_enabled
    }

    ip_configuration {
      ipv4_enabled    = true
      private_network = google_compute_network.serverpod.id
    }
  }

  deletion_protection = var.database_deletion_protection
}

resource "google_sql_database" "serverpod" {
  name     = "serverpod"
  instance = google_sql_database_instance.serverpod.name
}

resource "google_sql_user" "serverpod" {
  name     = "postgres"
  password = var.database_password
  instance = google_sql_database_instance.serverpod.name
}
