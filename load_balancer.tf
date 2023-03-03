# Serverpod API.

resource "google_compute_global_forwarding_rule" "api" {
  name                  = "serverpod-${var.runmode}-api"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  target                = google_compute_target_https_proxy.api.self_link
}

resource "google_compute_target_https_proxy" "api" {
  name             = "serverpod-${var.runmode}-proxy-api"
  url_map          = google_compute_url_map.serverpod.id
  ssl_certificates = [google_compute_managed_ssl_certificate.api.id]
}

# Serverpod Insights.

resource "google_compute_global_forwarding_rule" "insights" {
  name                  = "serverpod-${var.runmode}-insights"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  target                = google_compute_target_https_proxy.api.self_link
}

resource "google_compute_target_https_proxy" "insights" {
  name             = "serverpod-${var.runmode}-proxy-insights"
  url_map          = google_compute_url_map.serverpod.id
  ssl_certificates = [google_compute_managed_ssl_certificate.insights.id]
}

# Web server.

resource "google_compute_global_forwarding_rule" "web" {
  name                  = "serverpod-${var.runmode}-web"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  target                = google_compute_target_https_proxy.api.self_link
}

resource "google_compute_target_https_proxy" "web" {
  name             = "serverpod-${var.runmode}-proxy-web"
  url_map          = google_compute_url_map.serverpod.id
  ssl_certificates = var.use_top_domain_for_web ? [google_compute_managed_ssl_certificate.web.id, google_compute_managed_ssl_certificate.web-top-domain[0].id] : [google_compute_managed_ssl_certificate.web.id]
}

# Storage.

resource "google_compute_global_forwarding_rule" "storage" {
  name                  = "serverpod-${var.runmode}-storage"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  target                = google_compute_target_https_proxy.storage.self_link
}

resource "google_compute_target_https_proxy" "storage" {
  name             = "serverpod-${var.runmode}-proxy-storage"
  url_map          = google_compute_url_map.serverpod.id
  ssl_certificates = [google_compute_managed_ssl_certificate.storage.id]
}

# Load balancer.

resource "google_compute_url_map" "serverpod" {
  name            = "serverpod-${var.runmode}-balancer"
  default_service = google_compute_backend_service.web.id

  host_rule {
    hosts        = ["${var.subdomain_prefix}api.${var.top_domain}"]
    path_matcher = "api"
  }

  path_matcher {
    name            = "api"
    default_service = google_compute_backend_service.api.id
  }

  host_rule {
    hosts        = ["${var.subdomain_prefix}insights.${var.top_domain}"]
    path_matcher = "insights"
  }

  path_matcher {
    name            = "insights"
    default_service = google_compute_backend_service.insights.id
  }

  host_rule {
    hosts        = ["${var.subdomain_prefix}storage.${var.top_domain}"]
    path_matcher = "storage"
  }

  path_matcher {
    name            = "storage"
    default_service = google_compute_backend_bucket.storage.id
  }
}

# Load balancer backends.

resource "google_compute_backend_service" "api" {
  name     = "serverpod-${var.runmode}-backend-api"
  protocol = "HTTP"

  backend {
    group           = google_compute_instance_group_manager.serverpod.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = 1.0
    capacity_scaler = 1.0
  }

  health_checks = [google_compute_health_check.serverpod-balancer.id]

  port_name = "api"
}

resource "google_compute_backend_service" "insights" {
  name     = "serverpod-${var.runmode}-backend-insights"
  protocol = "HTTP"

  backend {
    group           = google_compute_instance_group_manager.serverpod.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = 1.0
    capacity_scaler = 1.0
  }

  health_checks = [google_compute_health_check.serverpod-balancer.id]

  port_name = "insights"
}

resource "google_compute_backend_service" "web" {
  name       = "serverpod-${var.runmode}-backend-web"
  protocol   = "HTTP"
  enable_cdn = true

  backend {
    group           = google_compute_instance_group_manager.serverpod.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = 1.0
    capacity_scaler = 1.0
  }

  health_checks = [google_compute_health_check.serverpod-balancer.id]

  port_name = "web"
}

resource "google_compute_backend_bucket" "storage" {
  name        = "serverpod-${var.runmode}-backend-storage"
  bucket_name = google_storage_bucket.public.name
  enable_cdn  = false
}

resource "google_compute_health_check" "serverpod-balancer" {
  name               = "serverpod-${var.runmode}-health-check"
  timeout_sec        = 5
  check_interval_sec = 5

  tcp_health_check {
    port = "8080"
  }
}