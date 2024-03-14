
# Identity Providers
resource "aws_iam_openid_connect_provider" "github" {
  url = local.constants.oidc.github.url

  client_id_list = [
    local.constants.oidc.github.audience,
  ]

  thumbprint_list = [
    data.tls_certificate.github.certificates[0].sha1_fingerprint
  ]
}
