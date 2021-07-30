variable "parameter_group_family" {
  description = "The family of the DB cluster parameter group"
  type        = string
  default     = "aurora-mysql5.7"
}

variable "db_parameter_group_name" {
  description = "The name of a DB parameter group to use"
  type        = string
  default     = null
}

variable "db_cluster_parameter_group_name" {
  description = "The name of a DB Cluster parameter group to use"
  type        = string
  default     = null
}

variable "parameters" {
  description = "A list of DB parameters to apply"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "apply_method" {
  description = "immediate or pending-reboot"
  default     = "immediate"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
