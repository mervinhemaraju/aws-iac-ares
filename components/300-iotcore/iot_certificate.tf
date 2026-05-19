# Device certificate used by the Pi to authenticate over MQTT
resource "aws_iot_certificate" "th3pl4gu3_pi" {
  active = true
}

# Attach the certificate to the Thing
resource "aws_iot_thing_principal_attachment" "th3pl4gu3_pi" {
  thing     = aws_iot_thing.th3pl4gu3_pi.name
  principal = aws_iot_certificate.th3pl4gu3_pi.arn
}

# Attach the IoT policy to the certificate
resource "aws_iot_policy_attachment" "th3pl4gu3_pi" {
  policy = aws_iot_policy.th3pl4gu3_pi.name
  target = aws_iot_certificate.th3pl4gu3_pi.arn
}
