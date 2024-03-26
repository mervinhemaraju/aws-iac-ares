locals {

  # > Tags for resources
  tags = {
    default = {
      Creator     = "mervin.hemaraju"
      Owner       = "mervin.hemaraju"
      Project     = "https://github.com/mervinhemaraju/aws-iac-ares"
      Usage       = "Personal"
      Environment = "Production"
      Codename    = "Ares"
      Terraform   = "Yes"
    }
  }

  constants = {

    owner_email_address = "mervinhemaraju16@gmail.com"

    # > Lambda default configurations
    lambda = {
      SOURCE_PATH          = "./functions/portfolio-contact-me/"
      RETRIES_ATTEMPT      = 0
      TIMEOUT              = "60"
      HANDLER              = "main.main"
      VERSION              = "python3.11"
      MEMORY_SIZE          = 128
      CLOUDWATCH_RETENTION = 7
      TRUSTED_ENTITIES = [
        {
          type = "Service",
          identifiers = [
            "lambda.amazonaws.com"
          ]
        }
      ]
    }

    # > SSM Default configurations
    ssm = {
      jeeyah_website = {
        bucket_list_categories = ["all", "travel", "food", "hobbies", "couple"]
      }
    }

    oidc = {
      github = {
        url      = "https://token.actions.githubusercontent.com"
        audience = "sts.amazonaws.com"
      }
    }
  }
}
