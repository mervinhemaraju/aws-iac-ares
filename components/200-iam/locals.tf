locals {

  # > Tags for resources
  tags = {
    default = {
      Creator     = "mervin.hemaraju"
      Owner       = "mervin.hemaraju"
      Project     = "https://github.com/mervinhemaraju/aws-iac-ares"
      Component   = "200-iam"
      Usage       = "Personal"
      Environment = "Production"
      Codename    = "Ares"
      Terraform   = "Yes"
    }
  }

  constants = {
    oidc = {
      github = {
        url      = "https://token.actions.githubusercontent.com"
        audience = "sts.amazonaws.com"
      }
    }
  }
}
