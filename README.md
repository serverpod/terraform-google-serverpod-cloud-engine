# Serverpod GCE Terraform module
Terraform module for deploying Serverpod to Google Cloud Engine.

The module will set up a complete Serverpod infrastructure with auto-scaling Cloud Engine instances and a Postgres database. It will also configure all necessary certificates and load balancing. You can opt into using Redis and Google Cloud Storage buckets.

Complete step-by-step instructions are available in the official Serverpod documentation [here](https://docs.serverpod.dev/deployments/deploying-to-gcp). See below for all the additional options you can use with this module.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.51.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_autoscaler.serverpod](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_autoscaler) | resource |
| [google_compute_backend_bucket.storage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_bucket) | resource |
| [google_compute_backend_service.api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service) | resource |
| [google_compute_backend_service.insights](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service) | resource |
| [google_compute_backend_service.web](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service) | resource |
| [google_compute_firewall.serverpod-instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.serverpod-instance-ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_global_address.private-ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_global_forwarding_rule.api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule) | resource |
| [google_compute_global_forwarding_rule.insights](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule) | resource |
| [google_compute_global_forwarding_rule.storage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule) | resource |
| [google_compute_global_forwarding_rule.web](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule) | resource |
| [google_compute_health_check.serverpod-balancer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check) | resource |
| [google_compute_health_check.serverpod-instance-group](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check) | resource |
| [google_compute_instance_group_manager.serverpod](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_group_manager) | resource |
| [google_compute_instance_template.serverpod](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template) | resource |
| [google_compute_managed_ssl_certificate.api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate) | resource |
| [google_compute_managed_ssl_certificate.insights](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate) | resource |
| [google_compute_managed_ssl_certificate.storage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate) | resource |
| [google_compute_managed_ssl_certificate.web](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate) | resource |
| [google_compute_managed_ssl_certificate.web-top-domain](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_managed_ssl_certificate) | resource |
| [google_compute_network.serverpod](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_target_https_proxy.api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_https_proxy) | resource |
| [google_compute_target_https_proxy.insights](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_https_proxy) | resource |
| [google_compute_target_https_proxy.storage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_https_proxy) | resource |
| [google_compute_target_https_proxy.web](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_https_proxy) | resource |
| [google_compute_url_map.serverpod](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map) | resource |
| [google_dns_managed_zone.private-dns](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone) | resource |
| [google_dns_managed_zone.public-dns](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone) | resource |
| [google_dns_record_set.api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_dns_record_set.database](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_dns_record_set.database-private](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_dns_record_set.insights](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_dns_record_set.redis-private](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_dns_record_set.storage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_dns_record_set.web](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_dns_record_set.web-top-domain](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_project_service.gcp_services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_redis_instance.serverpod](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/redis_instance) | resource |
| [google_service_networking_connection.private-vpc-connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [google_sql_database.serverpod](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.serverpod](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.serverpod](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [google_storage_bucket.private](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.public](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.public](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_cpu_utilization"></a> [autoscaling\_cpu\_utilization](#input\_autoscaling\_cpu\_utilization) | The CPU utilization to use for the autoscaling group. Defaults to 0.6. | `number` | `0.6` | no |
| <a name="input_autoscaling_max_size"></a> [autoscaling\_max\_size](#input\_autoscaling\_max\_size) | The maximum number of instances to run in the autoscaling group. Defaults to 2. | `number` | `2` | no |
| <a name="input_autoscaling_min_size"></a> [autoscaling\_min\_size](#input\_autoscaling\_min\_size) | The minimum number of instances to run in the autoscaling group. Defaults to 1. | `number` | `1` | no |
| <a name="input_database_availability_type"></a> [database\_availability\_type](#input\_database\_availability\_type) | The availability type of the database to use. Defaults to 'ZONAL', which represents a single zone. | `string` | `"ZONAL"` | no |
| <a name="input_database_backup_enabled"></a> [database\_backup\_enabled](#input\_database\_backup\_enabled) | Whether to enable backups for the database. Defaults to true. | `bool` | `true` | no |
| <a name="input_database_backup_point_in_time_recovery_enabled"></a> [database\_backup\_point\_in\_time\_recovery\_enabled](#input\_database\_backup\_point\_in\_time\_recovery\_enabled) | Whether to enable point in time recovery for the database. Defaults to false. | `bool` | `false` | no |
| <a name="input_database_deletion_protection"></a> [database\_deletion\_protection](#input\_database\_deletion\_protection) | Whether to enable deletion protection for the database. Defaults to true. | `bool` | `true` | no |
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | The password to use for the database. You can find the password in your 'config/passwords.yaml' file. | `string` | n/a | yes |
| <a name="input_database_tier"></a> [database\_tier](#input\_database\_tier) | The tier of the database to use. Defaults to 'db-f1-micro'. | `string` | `"db-f1-micro"` | no |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | The version of the database to use. Defaults to 'POSTGRES\_16'. Note that only PostgreSQL is supported. | `string` | `"POSTGRES_16"` | no |
| <a name="input_redis_version"></a> [redis\_version](#input\_redis\_version) | The version of Redis to use. Defaults to 'REDIS_7_2'. | `string` | `"REDIS_7_2"` | no |
| <a name="input_dns_managed_zone"></a> [dns\_managed\_zone](#input\_dns\_managed\_zone) | The name of the DNS managed zone to use for the Serverpod infrastructure. If this is not set, a new managed zone will be created. | `string` | `""` | no |
| <a name="input_enable_redis"></a> [enable\_redis](#input\_enable\_redis) | Whether to enable Redis. Defaults to false. | `bool` | `false` | no |
| <a name="input_enable_ssh"></a> [enable\_ssh](#input\_enable\_ssh) | Whether to enable SSH access to instances in the autoscaling group. Defaults to true. | `bool` | `true` | no |
| <a name="input_enable_storage"></a> [enable\_storage](#input\_enable\_storage) | Whether to enable storage. Defaults to true. | `bool` | `true` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The machine type to use for the autoscaling group. Defaults to 'e2-micro'. | `string` | `"e2-micro"` | no |
| <a name="input_project"></a> [project](#input\_project) | The GCP project ID to deploy your Serverpod infrastructure to. | `string` | n/a | yes |
| <a name="input_redis_memory_size_gb"></a> [redis\_memory\_size\_gb](#input\_redis\_memory\_size\_gb) | The memory size of the Redis instance to use in gigabytes, if it is enabled. Defaults to 1. | `number` | `1` | no |
| <a name="input_redis_tier"></a> [redis\_tier](#input\_redis\_tier) | The tier of the Redis instance to use, if it is enabled. Defaults to 'BASIC'. | `string` | `"BASIC"` | no |
| <a name="input_region"></a> [region](#input\_region) | The GCP region to deploy your Serverpod infrastructure to. Defaults to 'us-central1'. | `string` | `"us-central1"` | no |
| <a name="input_runmode"></a> [runmode](#input\_runmode) | The runmode to deploy your Serverpod infrastructure in. This can be 'production' or 'development'. | `string` | `"production"` | no |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | The email address of the service account to use for the Serverpod infrastructure. | `string` | `""` | no |
| <a name="input_storage_bucket_class"></a> [storage\_bucket\_class](#input\_storage\_bucket\_class) | The class of the storage buckets. Defaults to 'STANDARD'. | `string` | `"STANDARD"` | no |
| <a name="input_storage_bucket_location"></a> [storage\_bucket\_location](#input\_storage\_bucket\_location) | The location of the storage buckets. Defaults to 'US'. | `string` | `"US"` | no |
| <a name="input_subdomain_prefix"></a> [subdomain\_prefix](#input\_subdomain\_prefix) | The subdomain prefix to use for the Serverpod infrastructure. This is useful to set for your staging environment, in which case all sub domains will be prefixed with this value. | `string` | `""` | no |
| <a name="input_subdomain_web"></a> [subdomain\_web](#input\_subdomain\_web) | The subdomain to use for the web server. Defaults to 'app', but you may want to change it to 'www' if you have set 'use\_top\_domain\_for\_web' to true. | `string` | `"app"` | no |
| <a name="input_top_domain"></a> [top\_domain](#input\_top\_domain) | The top domain to deploy your Serverpod infrastructure to. E.g. 'example.com'. | `string` | n/a | yes |
| <a name="input_use_top_domain_for_web"></a> [use\_top\_domain\_for\_web](#input\_use\_top\_domain\_for\_web) | Whether to use the top domain for the web server. Defaults to false. | `bool` | `false` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The GCP zone to deploy your Serverpod infrastructure to. Defaults to 'us-central1-c'. | `string` | `"us-central1-c"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network"></a> [network](#output\_network) | The name of Serverpod's private network. |
<!-- END_TF_DOCS -->