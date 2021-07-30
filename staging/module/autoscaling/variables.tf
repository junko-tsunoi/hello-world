variable "asg_name" {
  description = "Name used across the resources created"
  type        = string
}

variable "launch_template_name" {
  description = "Name of an existing launch template to be used (created outside of this module)"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "The type of the instance to launch"
  type        = string
  default     = ""
}


variable "vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones`"
  type        = list(string)
  default     = null
}

variable "min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
  default     = null
}

variable "max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
  default     = null
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
  type        = number
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate"
  type        = list(string)
  default     = null
}

variable "target_group_arns" {
  description = "A set of `aws_alb_target_group` ARNs, for use with Application or Network Load Balancing"
  type        = list(string)
  default     = []
}

variable "iam_instance_profile_name" {
  description = "The name attribute of the IAM instance profile to associate with launched instances"
  type        = string
  default     = null
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = null
}

variable "user_data_base64" {
  description = "The Base64-encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "filters" {
  description = "Configuration block(s) for filtering."
  type        = list(object({
    name = string
    values = list(string)
  }))
  default     = []
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch"
  type        = list(map(string))
  default     = []
}

variable "launch_template_tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch"
  type        = map
  default     = {}
}
