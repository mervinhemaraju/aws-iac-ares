# Python lambda for Email Sending
module "portfolio_contact_me" {

  source  = "terraform-aws-modules/lambda/aws"
  version = "7.0.0"

  function_name = "portfolio-contact-me"
  description   = "The lambda for contacting me from my Portfolio."
  handler       = local.constants.lambda.HANDLER
  runtime       = local.constants.lambda.VERSION

  memory_size                       = local.constants.lambda.MEMORY_SIZE
  cloudwatch_logs_retention_in_days = local.constants.lambda.CLOUDWATCH_RETENTION
  source_path                       = local.constants.lambda.SOURCE_PATH
  timeout                           = local.constants.lambda.TIMEOUT
  create_async_event_config         = true
  maximum_retry_attempts            = local.constants.lambda.RETRIES_ATTEMPT

  create_lambda_function_url = true
  authorization_type         = "NONE"
  cors = {
    allow_credentials = false
    allow_origins = [
      "https://www.mervinhemaraju.com",
      "https://mervinhemaraju.com",
      "*" # Uncomment for testing purposes
    ]
    allow_methods  = ["POST"]
    allow_headers  = ["*"]
    expose_headers = ["*"]
  }

  attach_cloudwatch_logs_policy = true

  environment_variables = {
    RECEIVER_EMAIL       = local.constants.owner_email_address
    GMAIL_APP_PASSWORD   = data.doppler_secrets.prod_main.map.GMAIL_PERSONAL_APP_PASSWORD # TODO(Add KMS encryption)
    SLACK_CHANNEL_MAIN   = var.slack_channel_main
    SLACK_CHANNEL_ALERTS = var.slack_channel_alerts
  }

  trusted_entities = local.constants.lambda.TRUSTED_ENTITIES
}
