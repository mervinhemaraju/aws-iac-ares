# Get the TLS certificate from Github tokens
data "tls_certificate" "github" {
  url = local.constants.oidc.github.url
}

# Get the policy arn for the AWS Managed Administrator policy
data "aws_iam_policy" "administrator" {
  name = "AdministratorAccess"
}
