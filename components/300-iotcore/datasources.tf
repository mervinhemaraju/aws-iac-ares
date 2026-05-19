# IoT Core data endpoint
data "aws_iot_endpoint" "this" {
  endpoint_type = "iot:Data-ATS"
}

# Current account identity
data "aws_caller_identity" "current" {}

# Secrets from Doppler — project: apps-creds, config: prd
data "doppler_secrets" "apps_creds" {
  project = "apps-creds"
  config  = "prd"
}
