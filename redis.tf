# Redis instance, if enabled.

resource "google_redis_instance" "serverpod" {
  count = var.enable_redis ? 1 : 0

  name           = "serverpod-${var.runmode}-cache"
  tier           = var.redis_tier
  memory_size_gb = var.redis_memory_size_gb

  authorized_network = google_compute_network.serverpod.id
}