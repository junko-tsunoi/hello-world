output "autoscaling_group_name" {
  value = module.autoscaling_group.autoscaling_group_name
}

output "iam_role_arn" {
  value = module.iam_role.role_arn
}

output "iam_role_name" {
  value = module.iam_role.role_name
}

output "ssh_security_group_id" {
  value = module.ssh_security_group.security_group_id
}
