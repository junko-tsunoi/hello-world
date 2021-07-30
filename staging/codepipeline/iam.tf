data "template_file" "codepipeline" {
  template = file("./templates/codepipeline_basic_policy.json")
}

resource "aws_iam_policy" "codepipeline" {
  description = "Policy used in trust relationship with CodePipeline"
  name        = "AWSCodePipelineServicePolicy-${local.Project}"
  path        = "/service-role/"
  policy      = data.template_file.codepipeline.rendered
}

module "iam" {
  source = "../../module/iam/role"

  principal_service = ["codepipeline.amazonaws.com"]
  role_name         = "${local.Project}AWSCodePipelineServiceRole"
  policy_arns = [
    aws_iam_policy.codepipeline.arn,
  ]

  tags = {
    Owner = local.Owner
    Env   = local.env
  }
}

