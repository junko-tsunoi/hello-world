output "role_name" {
  description = "IAM role name"
  value       = aws_iam_role.default.name
}

output "role_arn" {
  description = "ARN of IAM role"
  value       = aws_iam_role.default.arn
}
