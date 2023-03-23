# Serverpod GCE Terraform module
Terraform module for deploying Serverpod to Google Cloud Engine.

The module will set up a complete Serverpod infrastructure with auto-scaling Cloud Engine instances and a Postgres database. It will also configure all necessary certificates and load balancing. You can opt into using Redis and Google Cloud Storage buckets.

Complete step-by-step instructions are available in the official Serverpod documentation [here](https://docs.serverpod.dev/next/deployments/deploying-to-gcp). See below for all the additional options you can use with this module.