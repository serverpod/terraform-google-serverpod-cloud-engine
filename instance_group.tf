# Template for instances running Serverpod's Docker container.

resource "google_compute_instance_template" "serverpod" {
  name        = "serverpod-${var.runmode}-template"
  description = "Instance template for Serverpod's Docker container."

  machine_type = var.machine_type

  disk {
    source_image = "cos-cloud/cos-stable"
  }

  # Startup script that runs the Serverpod Docker container.
  metadata_startup_script = <<-EOF
      #!/bin/bash
      useradd serverpod-user
      usermod -aG docker serverpod-user
      cd /home/serverpod-user
      sudo -u serverpod-user docker-credential-gcr configure-docker --registries ${var.region}-docker.pkg.dev
      sudo -u serverpod-user docker run -p 8080-8082:8080-8082 -e runmode=${var.runmode} -e serverid=$(hostname) ${var.region}-docker.pkg.dev/${var.project}/serverpod-${var.runmode}-container/serverpod:latest
    EOF

  network_interface {
    network = google_compute_network.serverpod.name
    access_config {
      # Ephemeral public IP.
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  tags = ["serverpod-${var.runmode}-instance", "serverpod-${var.runmode}-instance-ssh"]
}

# Instance group manager that runs the Serverpod Docker container, with autoscaling and health checks.

resource "google_compute_instance_group_manager" "serverpod" {
  name = "serverpod-${var.runmode}-group"
  version {
    instance_template = google_compute_instance_template.serverpod.id
  }
  base_instance_name = "serverpod-${var.runmode}"
  zone               = var.zone

  named_port {
    name = "api"
    port = 8080
  }

  named_port {
    name = "insights"
    port = 8081
  }

  named_port {
    name = "web"
    port = 8082
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.serverpod-instance-group.id
    initial_delay_sec = 300
  }
}

resource "google_compute_autoscaler" "serverpod" {
  name   = "serverpod-${var.runmode}-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.serverpod.id

  autoscaling_policy {
    min_replicas    = var.autoscaling_min_size
    max_replicas    = var.autoscaling_max_size
    cooldown_period = 60

    cpu_utilization {
      target = 0.6
    }
  }
}

resource "google_compute_health_check" "serverpod-instance-group" {
  name                = "serverpod-${var.runmode}-group-health-check"
  timeout_sec         = 5
  check_interval_sec  = 30
  healthy_threshold   = 2
  unhealthy_threshold = 3

  tcp_health_check {
    port = "8080"
  }
}