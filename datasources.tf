# Fetch secrets from Doppler secrets manager
data "doppler_secrets" "prod_main" {}

# Get the TLS certificate from Github tokens
data "tls_certificate" "github" {
  url = local.constants.oidc.github.url
}
