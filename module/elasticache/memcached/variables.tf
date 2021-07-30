## module/elasticache/memcached/variables.tf

variable "cluster_id"             {}
variable "engine"                 {}
variable "node_type"              {}
variable "num_cache_nodes"        {}
variable "port"                   {}
variable "subnet_group_name"      {}
variable "security_group_ids"     {}
variable "az_mode"                {}
variable "availability_zone"      {}
variable "maintenance_window"     {}
variable "parameter_group_family" {}
variable "parameter_group_name"   {}
variable "apply_immediately"      {}
variable "tags"                   {}
