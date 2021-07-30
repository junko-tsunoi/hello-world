# aws_cloudwatch_event_rule.event_rule:
resource "aws_cloudwatch_event_rule" "event_rule" {
  schedule_expression = var.schedule_expression
  is_enabled    = true
  name          = var.rule_name
  tags          = var.tags
}

# aws_cloudwatch_event_target.ecr_imagescan:
resource "aws_cloudwatch_event_target" "event_target" {
  rule      = aws_cloudwatch_event_rule.event_rule.name
  arn       = var.target_arn
}

output "event_rule_arn" {
  value = aws_cloudwatch_event_rule.event_rule.arn
}
