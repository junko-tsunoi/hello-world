variable "instance_num" {
  description = "Number of Instances"
  type        = number
  default     = 1
}

variable "apply_immediately" {
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window"
  type        = bool
  default     = false
}

variable "cluster_identifier" {
  description = "The cluster identifier specified on aws_rds_cluster"
  type        = list(any)
  default     = []
}

variable "availability_zones" {
  description = "The Availability Zone that the DB instance is created in"
  type        = list(string)
  default     = []
}

variable "engine" {
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
  type        = string
  default     = "aurora"
}

variable "engine_version" {
  description = "Aurora database engine version"
  type        = string
  default     = "5.7.mysql_aurora.2.10.0"
}

variable "instance_class" {
  description = "Instance cloass to use at master instance. If instance_type_replica is not set it will use the same type for replica instances"
  type        = string
  default     = ""
}

variable "db_subnet_group_name" {
  description = "The existing subnet group name to use"
  type        = string
  default     = ""
}

variable "db_parameter_group_name" {
  description = "The name of a DB parameter group to use"
  type        = string
  default     = null
}

variable "monitoring_role_arn" {
  description = "IAM role used by RDS to send enhanced monitoring metrics to CloudWatch"
  type        = string
  default     = ""
}

variable "monitoring_interval" {
  description = "The interval (seconds) between points when Enhanced Monitoring metrics are collected"
  type        = number
  default     = 0
}

variable "auto_minor_version_upgrade" {
  description = "Determines whether minor engine upgrades will be performed automatically in the maintenance window"
  type        = bool
  default     = false
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights is enabled or not"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
