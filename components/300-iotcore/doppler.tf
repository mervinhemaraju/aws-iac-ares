# Store the Pi device certificate and private key in Doppler for retrieval on the Pi
resource "doppler_secret" "iotcore_th3pl4gu3_pi_certificate" {
  project = "apps-creds"
  config  = "prd"
  name    = "AWS_IOTCORE_TH3PL4GU3_PI_CERTIFICATE"
  value = jsonencode({
    certificate = aws_iot_certificate.th3pl4gu3_pi.certificate_pem
    private_key = aws_iot_certificate.th3pl4gu3_pi.private_key
  })
}
