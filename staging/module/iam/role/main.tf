data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.principal_service
    }
  }
}

resource "aws_iam_role" "default" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  path               = var.role_path

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "default" {
  count      = length(var.policy_arns)
  role       = aws_iam_role.default.name
  policy_arn = element(var.policy_arns, count.index)
}

resource "aws_iam_instance_profile" "default" {
  count = var.create_instance_profile ? 1 : 0
  name  = aws_iam_role.default.name
  role  = aws_iam_role.default.name
}
