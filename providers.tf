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

  # * Terraform version
  required_version = ">= 1.0.0"

  # * AWS Provider
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.0"
    }
  }
}
