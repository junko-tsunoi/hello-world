output "cf_domain_name" { value = aws_cloudfront_distribution.main.domain_name }
output "cf_hosted_zone_id" { value = aws_cloudfront_distribution.main.hosted_zone_id }
output "s3_bucket_id" { value = module.log_bucket.s3_bucket_id }
output "s3_bucket_domain_name" { value = module.log_bucket.s3_bucket_domain_name }
output "s3_bucket_name" { value = module.log_bucket.s3_bucket_name }
