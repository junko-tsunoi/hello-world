module "iam_role" {
  source = "../../module/iam/role"

  principal_service = ["codedeploy.amazonaws.com"]
  role_name         = "${local.Project}${local.Env}CodeDeployRole"
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  ]

  tags = {
    Owner = local.Owner
    Env   = local.env
  }
}

