# aws_sns_topic.default:
resource "aws_sns_topic" "default" {

  display_name = var.display_name
  name         = var.topic_name
  policy       = var.policy
  tags         = var.tags
}

output "sns_topic_arn" {
  value = aws_sns_topic.default.arn
}
