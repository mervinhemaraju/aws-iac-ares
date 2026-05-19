module "slack_alert" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.0.0"

  function_name = "pi-health-slack-alert"
  description   = "Posts Pi health alerts to Slack when disk usage exceeds threshold"
  handler       = "slack_alert.handler"
  runtime       = "python3.12"

  source_path                       = "${path.module}/functions/slack_alert.py"
  cloudwatch_logs_retention_in_days = 7

  attach_cloudwatch_logs_policy = true

  environment_variables = {
    SLACK_WEBHOOK_URL = data.doppler_secrets.apps_creds.map.SLACK_HOOK_CHANNEL_ALERTS
  }
}

# Allow IoT Core to invoke the Lambda function via resource-based policy
resource "aws_lambda_permission" "iot_invoke_slack_alert" {
  statement_id  = "AllowIoTInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.slack_alert.lambda_function_name
  principal     = "iot.amazonaws.com"
}
