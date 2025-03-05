
#  Terraform AWS providers vars
variable "region" {
  type        = string
  description = "The AWS target region."
  default     = "eu-west-1"
}

variable "token_doppler_iac_cloud_main" {
  type        = string
  description = "The Doppler token for the secrets manager cloud main repo."
}

variable "bucket_key_prefix_iac" {
  type        = string
  description = "The prefix for the bucket key."
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket."
}

variable "bucket_region" {
  type        = string
  description = "The region of the bucket."
}

variable "slack_channel_main" {
  type        = string
  description = "The main slack channel to post to."
  default     = "#general"
}


variable "slack_channel_alerts" {
  type        = string
  description = "The alerting slack channel"
  default     = "#alerts"
}
