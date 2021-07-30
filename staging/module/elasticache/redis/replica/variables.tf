## module/elasticache/redis/replica/variables.tf

variable "at_rest_encryption_enabled"    {}
variable "auto_minor_version_upgrade"    {}
variable "automatic_failover_enabled"    {}
variable "engine"                        {}
variable "engine_version"                {}
variable "maintenance_window"            {}
variable "node_type"                     {}
variable "number_cache_clusters"         {}
variable "parameter_group_name"          {}
variable "parameter_group_family"        {}
variable "port"                          {}
variable "replication_group_description" {}
variable "replication_group_id"          {}
variable "security_group_ids"            {}
variable "snapshot_retention_limit"      {}
variable "snapshot_window"               {}
variable "subnet_group_name"             {}
variable "transit_encryption_enabled"    {}
variable "availability_zones"            {}
variable "tags"                          {}
variable "shard"                         { default = 1 }
variable "snapshot_arns"                 { default = [] }
