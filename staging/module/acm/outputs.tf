output "acm_arn" {
  description = "The ARN of the certificate"
  value = aws_acm_certificate.default.arn
}

output "acm_name" {
  description = "Name of the certificate"
  value = aws_acm_certificate.default.domain_name
}
