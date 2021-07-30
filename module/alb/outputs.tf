output "alb_arn" {
  description = "The ID and ARN of the load balancer we created."
  value = aws_alb.default.arn
}

output "alb_name" {
  description = "Name of the load balancer we created."
  value = aws_alb.default.name
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer."
  value = aws_alb.default.dns_name
}

output "alb_zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records."
  value = aws_alb.default.zone_id
}
