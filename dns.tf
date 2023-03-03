# Private DNS zone and records.

resource "google_dns_managed_zone" "private-dns" {
  name     = "serverpod-${var.runmode}-private"
  dns_name = "private-${var.runmode}.${var.top_domain}."

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.serverpod.id
    }
  }
}

resource "google_dns_record_set" "database-private" {
  name         = "database.private-${var.runmode}.${var.top_domain}."
  managed_zone = "serverpod-${var.runmode}-private"
  type         = "A"
  ttl          = 60
  rrdatas      = [google_sql_database_instance.serverpod.private_ip_address]
}

resource "google_dns_record_set" "redis-private" {
  count = var.enable_redis ? 1 : 0

  name         = "redis.private-${var.runmode}.${var.top_domain}."
  managed_zone = "serverpod-${var.runmode}-private"
  type         = "A"
  ttl          = 60
  rrdatas      = [google_redis_instance.serverpod[0].host]
}

# Public DNS zone and records.

resource "google_dns_managed_zone" "public-dns" {
  count = var.dns_managed_zone == "" ? 1 : 0

  name     = "serverpod-${var.runmode}-public"
  dns_name = "${var.top_domain}."
}

resource "google_dns_record_set" "api" {
  name         = "${var.subdomain_prefix}api.${var.top_domain}."
  managed_zone = var.dns_managed_zone == "" ? "serverpod-${var.runmode}-public" : var.dns_managed_zone
  type         = "A"
  ttl          = 60
  rrdatas      = [google_compute_global_forwarding_rule.api.ip_address]
}

resource "google_dns_record_set" "insights" {
  name         = "${var.subdomain_prefix}insights.${var.top_domain}."
  managed_zone = var.dns_managed_zone == "" ? "serverpod-${var.runmode}-public" : var.dns_managed_zone
  type         = "A"
  ttl          = 60
  rrdatas      = [google_compute_global_forwarding_rule.insights.ip_address]
}

resource "google_dns_record_set" "web" {
  name         = "${var.subdomain_prefix}${var.subdomain_web}.${var.top_domain}."
  managed_zone = var.dns_managed_zone == "" ? "serverpod-${var.runmode}-public" : var.dns_managed_zone
  type         = "A"
  ttl          = 60
  rrdatas      = [google_compute_global_forwarding_rule.web.ip_address]
}

resource "google_dns_record_set" "web-top-domain" {
  count        = var.use_top_domain_for_web ? 1 : 0
  name         = "${var.top_domain}."
  managed_zone = var.dns_managed_zone == "" ? "serverpod-${var.runmode}-public" : var.dns_managed_zone
  type         = "A"
  ttl          = 60
  rrdatas      = [google_compute_global_forwarding_rule.web.ip_address]
}

resource "google_dns_record_set" "storage" {
  name         = "${var.subdomain_prefix}storage.${var.top_domain}."
  managed_zone = var.dns_managed_zone == "" ? "serverpod-${var.runmode}-public" : var.dns_managed_zone
  type         = "A"
  ttl          = 60
  rrdatas      = [google_compute_global_forwarding_rule.storage.ip_address]
}

resource "google_dns_record_set" "database" {
  name         = "${var.subdomain_prefix}database.${var.top_domain}."
  managed_zone = var.dns_managed_zone == "" ? "serverpod-${var.runmode}-public" : var.dns_managed_zone
  type         = "A"
  ttl          = 60
  rrdatas      = [google_sql_database_instance.serverpod.public_ip_address]
}

