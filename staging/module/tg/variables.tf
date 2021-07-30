variable "alb_arn" {
  description = "The ID and ARN of the load balancer"
  type        = string
}

variable "listen_port" {
  description = "Port on which the load balancer is listening"
  type        = number
  default     = 443
}

variable "ssl_policy" {
  description = "The security policy if using HTTPS externally on the load balancer. [See](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html)."
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "certificate_arn" {
  description = "ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS."
  type        = string
}

variable "target_group_port" {
  description = "Port on which the load balancer is listening"
  type        = number
  default     = 80
}

variable "alb_target_group_name" {
  description = "Name of the target group."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "Identifier of the VPC in which to create the target group."
  type        = string
  default     = null
}

variable "deregistration_delay" {
  description = "Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused."
  type        = number
  default     = 300
}

variable "health_check_interval" {
  description = "Approximate amount of time"
  type        = number
  default     = 30
}

variable "health_check_path" {
  description = "Destination for the health check request."
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "Port to use to connect with the target."
  type        = number
  default     = 80
}

variable "health_check_timeout" {
  description = "Amount of time."
  type        = number
  default     = 5
}

variable "unhealthy_threshold" {
  description = "Number of consecutive health check failures required before considering the target unhealthy."
  type        = number
  default     = 3
}

variable "healthy_threshold" {
  description = "Number of consecutive health checks successes required before considering an unhealthy target healthy."
  type        = number
  default     = 3
}

variable "health_check_matcher" {
  description = "Response codes to use when checking for a healthy responses from a target."
  type        = string
  default     = "200"
}

variable "target_type" {
  description = "Type of target that you must specify when registering targets with this target group."
  type        = string
  default     = "instance"
}

variable "condition" {
  description = "A Condition block. Multiple condition blocks of different types can be set and all must be satisfied for the rule to match."
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}



