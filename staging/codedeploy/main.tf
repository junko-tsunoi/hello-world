locals {
  use = "batch"
}

resource "aws_codedeploy_app" "common" {
  name             = "${local.project}-${local.env}-codedeploy-app"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "main" {
  app_name               = aws_codedeploy_app.common.name
  autoscaling_groups     = [module.terraform_remote_state.ec2.outputs.autoscaling_group_name, module.terraform_remote_state.ec2.outputs.admin_autoscaling_group_name]
  deployment_group_name  = "${local.project}-${local.env}-codedeploy-group"
  deployment_config_name = "CodeDeployDefault.AllAtOnce"
  service_role_arn       = module.iam_role.role_arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  tags = {
    Owner = local.Owner
    Env   = local.env
  }
}

resource "aws_codedeploy_deployment_group" "batch" {
  app_name               = aws_codedeploy_app.common.name
  autoscaling_groups     = [module.terraform_remote_state.batch.outputs.autoscaling_group_name]
  deployment_group_name  = "${local.project}-${local.env}-${local.use}-codedeploy-group"
  deployment_config_name = "CodeDeployDefault.AllAtOnce"
  service_role_arn       = module.iam_role.role_arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  tags = {
    Owner = local.Owner
    Env   = local.env
  }
}
