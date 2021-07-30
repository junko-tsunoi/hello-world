variable "role_name" {
  description = "IAM role name"
  type        = string
  default     = ""
}

variable "principal_service" {

}

variable "policy_arns" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  type        = list(string)
  default     = []
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "create_instance_profile" {
  description = "Whether to create an instance profile"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}