resource "aws_iam_user" "dev_view" {
  name = "bedrock-dev-view"
  tags = {
    Project = "Bedrock"
  }
}

resource "aws_iam_user_policy_attachment" "readonly" {
  user       = aws_iam_user.dev_view.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_access_key" "dev_key" {
  user = aws_iam_user.dev_view.name
}
