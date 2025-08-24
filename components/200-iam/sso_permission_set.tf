# Administrator permission set and its attachment
resource "aws_ssoadmin_permission_set" "administrator_access" {
  instance_arn     = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  name             = "AdministratorAccess"
  description      = "Full administrator access"
  relay_state      = "https://${var.region}.console.aws.amazon.com/console/home?region=${var.region}#"
  session_duration = "PT6H"
}

resource "aws_ssoadmin_managed_policy_attachment" "administrators" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  managed_policy_arn = data.aws_iam_policy.administrator.arn
  permission_set_arn = aws_ssoadmin_permission_set.administrator_access.arn
}
