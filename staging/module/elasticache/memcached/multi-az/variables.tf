## module/elasticache/memcached/multi-az/variables.tf

variable "owner"                  {}
variable "env"                    {}
variable "datadog"                {}
variable "memcached_name"         {}
variable "engine"                 {}
variable "node_type"              {}
variable "num_cache_nodes"        {}
variable "parameter_group_family" {}
variable "port"                   {}
variable "subnet_group_name"      {}
variable "security_group_ids"     {}
variable "az_mode"                {}

