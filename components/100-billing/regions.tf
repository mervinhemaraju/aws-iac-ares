# Enables the af-south-1 region
resource "aws_account_region" "af_south_1" {
  region_name = "af-south-1"
  enabled     = true
}
