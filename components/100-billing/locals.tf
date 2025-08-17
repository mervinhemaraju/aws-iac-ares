locals {

  # > Tags for resources
  tags = {
    default = {
      Creator     = "mervin.hemaraju"
      Owner       = "mervin.hemaraju"
      Project     = "https://github.com/mervinhemaraju/aws-iac-ares"
      Component   = "100-billing"
      Usage       = "Personal"
      Environment = "Production"
      Codename    = "Ares"
      Terraform   = "Yes"
    }
  }

  constants = {
    owner_email_address = "mervinhemaraju16@gmail.com"
  }
}
