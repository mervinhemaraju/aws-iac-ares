
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


# IAM Roles
resource "aws_iam_role" "oidc_github" {
  name        = "github-actions"
  description = "The role for GitHub to assume"
  assume_role_policy = templatefile(
    "${path.module}/policies/iam_oidc_github_role_trust.json",
    {
      oidc_federated_arn   = aws_iam_openid_connect_provider.github.arn
      github_oidc_audience = local.constants.oidc.github.audience
    }
  )
  managed_policy_arns = [aws_iam_policy.oidc_github.arn]
}


# IAM Policies
resource "aws_iam_policy" "oidc_github" {
  name        = "github-actions"
  path        = "/"
  description = "The IAM actions allowed for Github to execute"
  policy = file(
    "${path.module}/policies/iam_oidc_github_role_actions.json"
  )
}
