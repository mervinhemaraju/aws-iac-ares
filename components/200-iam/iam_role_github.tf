# IAM Role
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
}


# IAM Policy
resource "aws_iam_policy" "oidc_github" {
  name        = "github-actions"
  path        = "/"
  description = "The IAM actions allowed for Github to execute"
  policy = file(
    "${path.module}/policies/iam_oidc_github_role_actions.json"
  )
}

# Role Policy Attachment
resource "aws_iam_role_policy_attachment" "oidc_github" {
  role       = aws_iam_role.oidc_github.name
  policy_arn = aws_iam_policy.oidc_github.arn
}
