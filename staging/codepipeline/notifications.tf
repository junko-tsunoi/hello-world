locals {
  service_name  = "codestar-notifications"
  slack_channel = "boys_mv_crop_deploy"
  event_type_ids = [
    "codepipeline-pipeline-action-execution-canceled",
    "codepipeline-pipeline-action-execution-failed",
    "codepipeline-pipeline-action-execution-started",
    "codepipeline-pipeline-pipeline-execution-canceled",
    "codepipeline-pipeline-pipeline-execution-failed",
    "codepipeline-pipeline-pipeline-execution-resumed",
    "codepipeline-pipeline-pipeline-execution-succeeded",
    "codepipeline-pipeline-pipeline-execution-superseded",
  ]
  targets = {
    web = {
      name     = "${aws_codepipeline.web.name}Status"
      resource = aws_codepipeline.web.arn
    },
    batch = {
      name     = "${aws_codepipeline.batch.name}Status"
      resource = aws_codepipeline.batch.arn
    }
  }
}

data "template_file" "chatbot" {
  template = file("./templates/chatbot_notification_only.json")
}

resource "aws_iam_policy" "chatbot" {
  description = "Policy used in trust relationship with CodePipeline"
  name        = "AWS-Chatbot-NotificationsOnly-Policy-${local.Project}${local.Env}"
  path        = "/service-role/"
  policy      = data.template_file.codepipeline.rendered
}

module "iam_chatbot" {
  source = "../../module/iam/role"

  principal_service = ["chatbot.amazonaws.com"]
  role_name         = "${local.Project}${local.Env}AWSChatbotRole"
  policy_arns = [
    aws_iam_policy.chatbot.arn,
  ]

  tags = {
    Owner = local.Owner
    Env   = local.env
  }
}

data "template_file" "sns_topic_policy" {
  template = file("./templates/codestar_notifications_policy.json")

  vars = {
    resource          = "arn:aws:sns:${local.region}:${local.aws_account_id}:${local.service_name}-${local.project}"
  }
}

resource "aws_sns_topic" "default" {

  display_name = "${local.service_name}-${local.project}"
  name         = "${local.service_name}-${local.project}"
  policy       = data.template_file.sns_topic_policy.rendered

  tags = {
    "Env"   = local.env
    "Owner" = local.Owner
  }
}

output "sns_topic_arn" {
  value = aws_sns_topic.default.arn
}

resource "aws_codestarnotifications_notification_rule" "default" {
  for_each = local.targets
  detail_type    = "FULL"
  event_type_ids = local.event_type_ids
  name           = each.value["name"]
  resource       = each.value["resource"]
  status         = "ENABLED"
  tags = {
    "Env"   = local.env
    "Owner" = local.Owner
  }

  target {
    address = "arn:aws:chatbot::${local.aws_account_id}:chat-configuration/slack-channel/${local.slack_channel}"
    type    = "AWSChatbotSlack"
  }
}
