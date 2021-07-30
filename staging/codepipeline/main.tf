locals {
  organization    = "hekk"
  repository      = "boys_mv_crop"
  branch          = "staging"
  provider_type   = "GitHub"
  source_provider = "CodeStarSourceConnection"
}

resource "aws_codestarconnections_connection" "common" {
  name          = "${local.project}-${local.env}"
  provider_type = local.provider_type
}

resource "aws_codepipeline" "web" {
  name     = "${local.Project}${local.Env}"
  role_arn = module.iam.role_arn

  tags = {
    Owner = local.Owner
    Env   = local.env
  }

  artifact_store {
    location = aws_s3_bucket.codepipeline.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      category = "Source"
      configuration = {
        "BranchName"           = local.branch
        "ConnectionArn"        = aws_codestarconnections_connection.common.arn
        "FullRepositoryId"     = "${local.organization}/${local.repository}_web"
        "OutputArtifactFormat" = "CODE_ZIP"
      }
      input_artifacts = []
      name            = "Source"
      namespace       = "SourceVariables"
      output_artifacts = [
        "SourceArtifact",
      ]
      owner     = "AWS"
      provider  = local.source_provider
      region    = local.region
      run_order = 1
      version   = "1"
    }
  }
  stage {
    name = "Deploy"

    action {
      category = "Deploy"
      configuration = {
        "ApplicationName"     = module.terraform_remote_state.codedeploy.outputs.app_name_main
        "DeploymentGroupName" = module.terraform_remote_state.codedeploy.outputs.deployment_group_name_main
      }
      input_artifacts = [
        "SourceArtifact",
      ]
      name             = "Deploy"
      namespace        = "DeployVariables"
      output_artifacts = []
      owner            = "AWS"
      provider         = "CodeDeploy"
      region           = local.region
      run_order        = 1
      version          = "1"
    }
  }
}
