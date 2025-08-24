# Administrator user and its assignment
resource "aws_identitystore_user" "administrator" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]

  display_name = "Mervin Hemaraju"
  user_name    = "th3pl4gu3"

  name {
    given_name  = "Mervin"
    family_name = "Hemaraju"
  }

  emails {
    value = "mervinhemaraju16@gmail.com"
  }
}

resource "aws_identitystore_group_membership" "administrator" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  group_id          = aws_identitystore_group.administrators.group_id
  member_id         = aws_identitystore_user.administrator.user_id
}
