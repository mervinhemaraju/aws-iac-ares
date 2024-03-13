# * Define our data source to fetch secrets
data "doppler_secrets" "prod_main" {}

data "tls_certificate" "example" {
  url = "https://token.actions.githubusercontent.com"
}
