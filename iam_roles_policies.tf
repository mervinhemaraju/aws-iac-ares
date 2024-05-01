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

# Scheduler IAM Role
resource "aws_iam_role" "scheduler_oci_inspector" {
  name                = "scheduler-oci-inspector"
  description         = "The scheduler role for the oci inspector project"
  assume_role_policy  = file("${path.module}/policies/iam_scheduler_role_trust.json")
  managed_policy_arns = [aws_iam_policy.scheduler.arn]

  depends_on = [aws_iam_policy.scheduler_oci_inspector]
}

# Scheduler IAM Policy
resource "aws_iam_policy" "scheduler_oci_inspector" {

  name        = "scheduler-oci-inspector-policy"
  path        = "/"
  description = "The scheduler actions for the project oci inspector"
  policy = templatefile(
    "${path.module}/policies/iam_scheduler_role_actions.json",
    {
      lambda_arn = "arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:oci-inspector-*"
    }
  )
}
