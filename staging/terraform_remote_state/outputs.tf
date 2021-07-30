output "vpc" {
  value = var.vpc ? data.terraform_remote_state.vpc[0] : null
}

output "aurora" {
  value = var.aurora ? data.terraform_remote_state.aurora[0] : null
}

output "acm" {
  value = var.acm ? data.terraform_remote_state.acm[0] : null
}

output "s3" {
  value = var.s3 ? data.terraform_remote_state.s3[0] : null
}

output "ec2" {
  value = var.ec2 ? data.terraform_remote_state.ec2[0] : null
}

output "batch" {
  value = var.batch ? data.terraform_remote_state.batch[0] : null
}

output "cloudfront" {
  value = var.cloudfront ? data.terraform_remote_state.cloudfront[0] : null
}

output "codedeploy" {
  value = var.codedeploy ? data.terraform_remote_state.codedeploy[0] : null
}
