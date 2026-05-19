# IoT policy granting the Pi permission to connect and publish health metrics
resource "aws_iot_policy" "th3pl4gu3_pi" {
  name = "th3pl4gu3-pi-health-monitor"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "iot:Connect"
        Resource = "arn:aws:iot:${var.region}:${data.aws_caller_identity.current.account_id}:client/${local.constants.thing_name}"
      },
      {
        Effect   = "Allow"
        Action   = "iot:Publish"
        Resource = "arn:aws:iot:${var.region}:${data.aws_caller_identity.current.account_id}:topic/${local.constants.mqtt_topic}"
      }
    ]
  })
}
