output "listener_arn" {
  description = "The ARN of the load balancer listeners created."
  value       = aws_alb_listener.this.arn
}

output "target_group_arn" {
  description = "ARN of the target groups. Useful for passing to your Auto Scaling group."
  value       = aws_alb_target_group.this.arn
}

output "target_group_name" {
  description = "Name of the target group."
  value       = aws_alb_target_group.this.name
}
