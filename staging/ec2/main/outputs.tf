output "alb_name" {
  value = module.alb.alb_name
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "log_s3_bucket_id" {
  value = module.log_s3_bucket.s3_bucket_id
}

output "log_s3_bucket_domain_name" {
  value = module.log_s3_bucket.s3_bucket_domain_name
}

output "autoscaling_group_name" {
  value = module.autoscaling_group.autoscaling_group_name
}

output "admin_autoscaling_group_name" {
  value = module.admin_autoscaling_group.autoscaling_group_name
}

output "iam_role_arn" {
  value = module.iam_role.role_arn
}

output "iam_role_name" {
  value = module.iam_role.role_name
}

output "default_security_group_id" {
  value = module.default_security_group.security_group_id
}
