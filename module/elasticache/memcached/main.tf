## module/elasticache/memcached/main.tf

resource "aws_elasticache_cluster" "default" {

  preferred_availability_zones  = var.availability_zone

  az_mode                  = var.az_mode
  cluster_id               = var.cluster_id
  engine                   = var.engine
  engine_version           = "1.5.16"
  maintenance_window       = var.maintenance_window
  node_type                = var.node_type
  num_cache_nodes          = var.num_cache_nodes
  parameter_group_name     = var.parameter_group_name
  port                     = var.port
  security_group_ids       = [ var.security_group_ids ]
  subnet_group_name        = var.subnet_group_name
  apply_immediately        = var.apply_immediately
  tags                     = var.tags
}

resource "aws_elasticache_parameter_group" "default" {
  name   = var.parameter_group_name
  family = var.parameter_group_family
}

