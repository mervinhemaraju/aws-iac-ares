# MQTT endpoint — use this as the broker host in the Pi's health monitor script
output "iot_endpoint" {
  description = "The IoT Core ATS data endpoint for MQTT connections"
  value       = data.aws_iot_endpoint.this.endpoint_address
}
