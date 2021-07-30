locals {
  use = "batch"
  Use = "Batch"
}

resource "aws_codepipeline" "batch" {
  name     = "${local.Project}${local.Env}${local.Use}"
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
        "FullRepositoryId"     = "${local.organization}/${local.repository}_${local.use}"
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
        "DeploymentGroupName" = module.terraform_remote_state.codedeploy.outputs.deployment_group_name_batch
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
