variable "security_group_name" {
  description = "Name used across resources created"
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""
}

variable "ingress" {
  description = "Configuration block for ingress rules"
  type = map(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = list(string)
    self            = bool
    description     = string
  }))
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}