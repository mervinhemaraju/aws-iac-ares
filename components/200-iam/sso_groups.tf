# Administrator access sso group
resource "aws_identitystore_group" "administrators" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  display_name      = "administrators"
  description       = "Full Administrator access."
}
