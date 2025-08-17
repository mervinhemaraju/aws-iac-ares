resource "aws_iam_user" "sandbox" {
  name = "sandbox"
  path = "/"
}

resource "aws_iam_user_policy_attachment" "sandbox_administrator" {
  user       = aws_iam_user.sandbox.name
  policy_arn = data.aws_iam_policy.administrator.arn
}
