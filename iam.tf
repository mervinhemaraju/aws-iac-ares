
# Identity Providers
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    data.tls_certificate.example.certificates[0].sha1_fingerprint
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
      github_oidc_audience = "sts.amazonaws.com"
    }
  )
  managed_policy_arns = [aws_iam_policy.oidc_github.arn]
}


# IAM Policies
resource "aws_iam_policy" "oidc_github" {

  name        = "github-actions"
  path        = "/"
  description = "The iam actions allowed for Github to execute"
  policy = file(
    "${path.module}/policies/iam_oidc_github_role_actions.json"
  )
}
