# > Secret variable
# * Terraform AWS providers vars
variable "region" {
  type        = string
  description = "The AWS target region."
  default     = "eu-west-1"
}

variable "token_doppler_iac_cloud_main" {
  type        = string
  description = "The Doppler token for the secrets manager cloud main repo."
}
