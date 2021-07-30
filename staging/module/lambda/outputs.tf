output "arn" {
  value = aws_lambda_function.lambda.arn
}

output "function_name" {
  value = aws_lambda_function.lambda.function_name
}

output "version" {
  value = aws_lambda_function.lambda.version
}

output "qualified_arn" {
  value = aws_lambda_function.lambda.qualified_arn
}
