# IoT Thing representing the Raspberry Pi
resource "aws_iot_thing" "th3pl4gu3_pi" {
  name = local.constants.thing_name
}
