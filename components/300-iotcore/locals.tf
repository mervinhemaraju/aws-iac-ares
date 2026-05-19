locals {

  # > Tags for resources
  tags = {
    default = {
      Creator     = "mervin.hemaraju"
      Owner       = "mervin.hemaraju"
      Project     = "https://github.com/mervinhemaraju/aws-iac-ares"
      Component   = "300-iotcore"
      Usage       = "Personal"
      Environment = "Production"
      Codename    = "Ares"
      Terraform   = "Yes"
    }
  }

  constants = {
    thing_name           = "th3pl4gu3-pi"
    mqtt_topic           = "pi/health"
    alert_email          = "mervinhemaraju16@gmail.com"
    disk_alert_threshold = 80
  }
}
