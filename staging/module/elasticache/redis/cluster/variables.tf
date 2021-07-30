## module/elasticache/redis/cluster/variables.tf

variable "replication_group_id" {}
variable "engine" {}
variable "engine_version" {}
variable "node_type" {}
variable "automatic_failover_enabled" {}
variable "maintenance_window" {}
variable "snapshot_window" {}
variable "snapshot_retention_limit" {}
variable "multi_az_enabled" {}
variable "parameter_group_name" {}
variable "parameter_group_family" {}
variable "port" {}
variable "num_node_groups" {}
#variable "number_cache_clusters" {}
variable "replicas_per_node_group" {}
variable "subnet_group_name" {}
variable "security_group_ids" {}
variable "replication_group_description" {}
variable "tags" {}
