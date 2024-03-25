
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
