# Administrator access sso group and aws account access
resource "aws_identitystore_group" "administrators" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  display_name      = "administrators"
  description       = "Full Administrator access."
}

resource "aws_ssoadmin_account_assignment" "current" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.administrator_access.arn

  principal_id   = aws_identitystore_group.administrators.group_id
  principal_type = "GROUP"

  target_id   = data.aws_caller_identity.current.account_id
  target_type = "AWS_ACCOUNT"
}
