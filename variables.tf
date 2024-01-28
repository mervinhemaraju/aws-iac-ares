# > Secret variable
# * Terraform AWS providers vars
variable "region" {
  type        = string
  description = "The AWS target region."
  default     = "eu-west-1"
}

variable "gmail_app_token" {
  type        = string
  description = "The GMAIL app token for the email sending lambda."
}
