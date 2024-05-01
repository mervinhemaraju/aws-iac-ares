# * Terraform Provider for AWS for the connection
provider "aws" {

  # * The AWS Environment Configurations
  region = var.region

  # * The Default Tags
  default_tags {
    tags = local.tags.default
  }
}

# * Doppler Provider for Secrets Manager
provider "doppler" {
  doppler_token = var.token_doppler_iac_cloud_main
}

# * The Terraform Module
terraform {

  # * Terraform version
  required_version = ">= 1.0.0"

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

    doppler = {
      source  = "DopplerHQ/doppler"
      version = "1.7.0"
    }
  }
}
