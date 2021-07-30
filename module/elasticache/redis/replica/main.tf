## module/elasticache/redis/replica/main.tf

resource "aws_elasticache_replication_group" "default" {
  count                         = var.shard
  automatic_failover_enabled    = var.automatic_failover_enabled
  auto_minor_version_upgrade    = var.auto_minor_version_upgrade
#  replication_group_id          = var.replication_group_id
  replication_group_id          = "${var.replication_group_id}${format("%02d", count.index + 1)}"
  replication_group_description = var.replication_group_description
  engine                        = var.engine
  engine_version                = var.engine_version
  node_type                     = var.node_type
  number_cache_clusters         = var.number_cache_clusters
  port                          = var.port
  snapshot_window               = var.snapshot_window
  snapshot_retention_limit      = var.snapshot_retention_limit
  maintenance_window            = var.maintenance_window
  subnet_group_name             = var.subnet_group_name
  security_group_ids            = var.security_group_ids[*]
  parameter_group_name          = aws_elasticache_parameter_group.default.name
  availability_zones            = var.availability_zones
  snapshot_arns                 = var.snapshot_arns
  tags                          = var.tags
}

resource "aws_elasticache_parameter_group" "default" {
  name   = var.replication_group_id
  family = var.parameter_group_family

  parameter {
    name = "cluster-enabled"
    value = "no"
  }
}

