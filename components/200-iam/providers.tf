# * Terraform Provider for AWS for the connection
provider "aws" {

  # * The AWS Environment Configurations
  region = var.region

  # * The Default Tags
  default_tags {
    tags = local.tags.default
  }
}

# * The Terraform Module
terraform {

  # The required tf version
  required_version = "1.8.7"

  # Backend configuration
  backend "s3" {
    region = var.bucket_region
    key    = "${var.bucket_key_prefix_iac}/iam/state.tf"
    bucket = var.bucket_name
  }

  # * AWS Provider
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}
