output "autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = element(concat(aws_autoscaling_group.this.*.name, [""]), 0)
}