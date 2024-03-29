# Main setup.

terraform {
  required_version = ">= 1.3.9"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.51.0"
    }
  }
}
