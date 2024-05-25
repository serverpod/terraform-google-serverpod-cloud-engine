variable "project" {
  description = "The GCP project ID to deploy your Serverpod infrastructure to."
  type        = string
}

variable "runmode" {
  description = "The runmode to deploy your Serverpod infrastructure in. This can be 'production' or 'development'."
  type        = string
  default     = "production"
}

variable "region" {
  description = "The GCP region to deploy your Serverpod infrastructure to. Defaults to 'us-central1'."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone to deploy your Serverpod infrastructure to. Defaults to 'us-central1-c'."
  type        = string
  default     = "us-central1-c"
}

variable "top_domain" {
  description = "The top domain to deploy your Serverpod infrastructure to. E.g. 'example.com'."
  type        = string
}

variable "autoscaling_min_size" {
  description = "The minimum number of instances to run in the autoscaling group. Defaults to 1."
  default     = 1
}

variable "autoscaling_max_size" {
  description = "The maximum number of instances to run in the autoscaling group. Defaults to 2."
  default     = 2
}

variable "service_account_email" {
  description = "The email address of the service account to use for the Serverpod infrastructure."
  type        = string
  default     = ""
}

variable "autoscaling_cpu_utilization" {
  description = "The CPU utilization to use for the autoscaling group. Defaults to 0.6."
  type        = number
  default     = 0.6
}

variable "machine_type" {
  description = "The machine type to use for the autoscaling group. Defaults to 'e2-micro'."
  type        = string
  default     = "e2-micro"
}

variable "enable_ssh" {
  description = "Whether to enable SSH access to instances in the autoscaling group. Defaults to true."
  type        = bool
  default     = true
}

variable "database_version" {
  description = "The version of the database to use. Defaults to 'POSTGRES_14'. Note that only PostgreSQL is supported."
  type        = string
  default     = "POSTGRES_14"
}

variable "redis_version" {
  description = "The version of Redis to use. Defaults to 'REDIS_7_2'."
  type        = string
  default     = "REDIS_7_2"
}

variable "database_tier" {
  description = "The tier of the database to use. Defaults to 'db-f1-micro'."
  type        = string
  default     = "db-f1-micro"
}

variable "database_deletion_protection" {
  description = "Whether to enable deletion protection for the database. Defaults to true."
  type        = bool
  default     = true
}

variable "database_availability_type" {
  description = "The availability type of the database to use. Defaults to 'ZONAL', which represents a single zone."
  type        = string
  default     = "ZONAL"
}

variable "database_backup_enabled" {
  description = "Whether to enable backups for the database. Defaults to true."
  type        = bool
  default     = true
}

variable "database_backup_point_in_time_recovery_enabled" {
  description = "Whether to enable point in time recovery for the database. Defaults to false."
  type        = bool
  default     = false
}

variable "database_password" {
  description = "The password to use for the database. You can find the password in your 'config/passwords.yaml' file."
  type        = string
}

variable "dns_managed_zone" {
  description = "The name of the DNS managed zone to use for the Serverpod infrastructure. If this is not set, a new managed zone will be created."
  type        = string
  default     = ""
}

variable "subdomain_prefix" {
  description = "The subdomain prefix to use for the Serverpod infrastructure. This is useful to set for your staging environment, in which case all sub domains will be prefixed with this value."
  type        = string
  default     = ""
}

variable "subdomain_web" {
  description = "The subdomain to use for the web server. Defaults to 'app', but you may want to change it to 'www' if you have set 'use_top_domain_for_web' to true."
  type        = string
  default     = "app"
}

variable "use_top_domain_for_web" {
  description = "Whether to use the top domain for the web server. Defaults to false."
  type        = bool
  default     = false
}

variable "enable_redis" {
  description = "Whether to enable Redis. Defaults to false."
  type        = bool
  default     = false
}

variable "redis_tier" {
  description = "The tier of the Redis instance to use, if it is enabled. Defaults to 'BASIC'."
  type        = string
  default     = "BASIC"
}

variable "redis_memory_size_gb" {
  description = "The memory size of the Redis instance to use in gigabytes, if it is enabled. Defaults to 1."
  type        = number
  default     = 1
}

variable "enable_storage" {
  description = "Whether to enable storage. Defaults to true."
  type        = bool
  default     = true
}

variable "storage_bucket_location" {
  description = "The location of the storage buckets. Defaults to 'US'."
  type        = string
  default     = "US"
}

variable "storage_bucket_class" {
  description = "The class of the storage buckets. Defaults to 'STANDARD'."
  type        = string
  default     = "STANDARD"
}