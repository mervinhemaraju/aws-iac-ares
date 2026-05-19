# Rule: trigger SNS alert when disk usage exceeds the configured threshold
resource "aws_iot_topic_rule" "pi_health_disk_alert" {
  name        = "pi_health_disk_alert"
  description = "Triggers a Slack alert when Pi disk usage exceeds threshold"
  enabled     = true
  sql_version = "2016-03-23"
  sql         = "SELECT * FROM '${local.constants.mqtt_topic}' WHERE disk_pct > ${local.constants.disk_alert_threshold}"

  lambda {
    function_arn = module.slack_alert.lambda_function_arn
  }
}
