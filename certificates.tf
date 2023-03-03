# SSL certificates.

resource "google_compute_managed_ssl_certificate" "api" {
  name = "serverpod-${var.runmode}-api-certificate"

  managed {
    domains = ["${var.subdomain_prefix}api.${var.top_domain}."]
  }
}

resource "google_compute_managed_ssl_certificate" "insights" {
  name = "serverpod-${var.runmode}-insights-certificate"

  managed {
    domains = ["${var.subdomain_prefix}insights.${var.top_domain}."]
  }
}

resource "google_compute_managed_ssl_certificate" "web" {
  name = "serverpod-${var.runmode}-web-certificate"

  managed {
    domains = ["${var.subdomain_prefix}${var.subdomain_web}.${var.top_domain}."]
  }
}

resource "google_compute_managed_ssl_certificate" "web-top-domain" {
  count = var.use_top_domain_for_web ? 1 : 0

  name = "serverpod-${var.runmode}-web-top-domain-certificate"

  managed {
    domains = ["${var.top_domain}."]
  }
}

resource "google_compute_managed_ssl_certificate" "storage" {
  name = "serverpod-${var.runmode}-storage-certificate"

  managed {
    domains = ["${var.subdomain_prefix}storage.${var.top_domain}."]
  }
}