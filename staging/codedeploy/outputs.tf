output "app_name_main" {
  value = aws_codedeploy_app.common.name
}

output "deployment_group_name_main" {
  value = aws_codedeploy_deployment_group.main.deployment_group_name
}

output "deployment_group_name_batch" {
  value = aws_codedeploy_deployment_group.batch.deployment_group_name
}
