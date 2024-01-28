locals {

  # > Tags for resources
  tags = {
    default = {
      Creator     = "mervin.hemaraju"
      Project     = "Ares"
      Usage       = "Personal"
      Environment = "Production"
    }
  }

  constants = {

    # > Lambda default configurations
    lambda = {
      SOURCE_PATH          = "./functions/email-function/"
      RETRIES_ATTEMPT      = 0
      TIMEOUT              = "60"
      HANDLER              = "main.main"
      VERSION              = "python3.9"
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
  }
}
