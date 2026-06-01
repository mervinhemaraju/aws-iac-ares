locals {

  # > Tags for resources
  tags = {
    default = {
      Creator     = "mervin.hemaraju"
      Owner       = "mervin.hemaraju"
      Project     = "https://github.com/mervinhemaraju/aws-iac-ares"
      Component   = "400-storage"
      Usage       = "Personal"
      Environment = "Production"
      Codename    = "Ares"
      Terraform   = "Yes"
    }
  }

  # > State file buckets
  state_buckets = [
    { name = "iac-github" },
    { name = "iac-cloudflare" },
    { name = "iac-spacelift" },
    { name = "iac-aws-ares" },
    { name = "iac-oracle-cloud" },
  ]
}
