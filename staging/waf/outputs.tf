output "s3_bucket_arn" {
  value = module.log_bucket.s3_bucket_arn
}

output "iam_role_arn" {
  value = module.iam_role.role_arn
}
