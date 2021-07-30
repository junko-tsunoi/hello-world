variable "shard" {
  description = "Number of shards"
  type        = number
  default     = 1
}

variable "cluster_name" {
  description = "The global cluster name on aws_rds_global_cluster"
  type        = string
  default     = ""
}

variable "prefix_name" {
  description = "Prefix that identifies the shard"
  type        = string
  default     = ""
}

variable "apply_immediately" {
  description = "Determines whether or not any DB modifications are applied immediately, or during the maintenance window"
  type        = bool
  default     = false
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate to the cluster in addition to the SG we create in this module"
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

variable "engine_mode" {
  description = "The database engine mode. Valid values: global, parallelquery, provisioned, serverless, multimaster"
  type        = string
  default     = "provisioned"
}

variable "port" {
  description = "The port on which to accept connections"
  type        = number
  default     = 3306
}

variable "db_cluster_parameter_group_name" {
  description = "The name of a DB Cluster parameter group to use"
  type        = string
  default     = null
}

variable "master_username" {
  description = "Master DB username"
  type        = string
  default     = "root"
}

variable "master_password" {
  description = "Master DB password. Note - when specifying a value here, 'create_random_password' should be set to `false`"
  type        = string
  default     = ""
}

variable "db_subnet_group_name" {
  description = "The existing subnet group name to use"
  type        = string
  default     = ""
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to cloudwatch - `audit`, `error`, `general`, `slowquery`, `postgresql`"
  type        = list(string)
  default     = []
}

variable "backtrack_window" {
  description = "The target backtrack window, in seconds. Only available for aurora engine currently. To disable backtracking, set this value to 0. Must be between 0 and 259200 (72 hours)"
  type        = number
  default     = 0
}

variable "backup_retention_period" {
  description = "How long to keep backups for (in days)"
  type        = number
  default     = 7
}

variable "preferred_backup_window" {
  description = "When to perform DB backups"
  type        = string
  default     = "19:00-20:00"
}

variable "preferred_maintenance_window" {
  description = "When to perform DB maintenance"
  type        = string
  default     = "sun:05:00-sun:06:00"
}

variable "storage_encrypted" {
  description = "Specifies whether the underlying storage layer should be encrypted"
  type        = bool
  default     = true
}

variable "iam_roles" {
  description = "A List of ARNs for the IAM roles to associate to the RDS Cluster"
  type        = list(string)
  default     = []
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
