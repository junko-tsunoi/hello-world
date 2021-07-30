## module/elasticache/redis/cluster/main.tf

resource "aws_elasticache_replication_group" "default" {
  automatic_failover_enabled    = var.automatic_failover_enabled
  replication_group_id          = var.replication_group_id
  engine                        = var.engine
  engine_version                = var.engine_version
  node_type                     = var.node_type
  parameter_group_name          = aws_elasticache_parameter_group.default.name
  port                          = var.port
  maintenance_window            = var.maintenance_window
  snapshot_window               = var.snapshot_window
  snapshot_retention_limit      = var.snapshot_retention_limit
  subnet_group_name             = var.subnet_group_name
  security_group_ids            = var.security_group_ids[*]
  replication_group_description = var.replication_group_description
  multi_az_enabled              = var.multi_az_enabled
  auto_minor_version_upgrade    = false

  cluster_mode {
    num_node_groups         = var.num_node_groups
    replicas_per_node_group = var.replicas_per_node_group
  }

  tags = var.tags
}

resource "aws_elasticache_parameter_group" "default" {
  name   = var.replication_group_id
  family = var.parameter_group_family

  parameter {
    name  = "cluster-enabled"
    value = "yes"
  }
}
