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
      ipv4_enabled        = true
      private_network     = google_compute_network.serverpod.id
      
      dynamic "authorized_networks" {
        for_each = var.authorized_networks == null ? [] : [var.authorized_networks]
        content {
          name = var.authorized_networks.name
          value = var.authorized_networks.value
        }
      }
    }
  }

  deletion_protection = var.database_deletion_protection

  depends_on = [google_service_networking_connection.private-vpc-connection]
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
