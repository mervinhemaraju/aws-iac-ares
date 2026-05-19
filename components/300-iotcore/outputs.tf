# MQTT endpoint — use this as the broker host in the Pi's health monitor script
output "iot_endpoint" {
  description = "The IoT Core ATS data endpoint for MQTT connections"
  value       = data.aws_iot_endpoint.this.endpoint_address
}

# Device certificate — copy to Pi as device.cert.pem
output "certificate_pem" {
  description = "The device certificate PEM to copy to the Pi"
  value       = aws_iot_certificate.th3pl4gu3_pi.certificate_pem
  sensitive   = true
}

# Device private key — copy to Pi as device.private.key
output "private_key" {
  description = "The device private key to copy to the Pi"
  value       = aws_iot_certificate.th3pl4gu3_pi.private_key
  sensitive   = true
}
