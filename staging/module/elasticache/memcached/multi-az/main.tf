## module/elasticache/memcached/multi-az/main.tf

resource "aws_elasticache_cluster" "multi" {
  cluster_id           = var.memcached_name
  engine               = var.engine
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  az_mode              = var.az_mode
  parameter_group_name = aws_elasticache_parameter_group.multi.name
  port                 = var.port
  subnet_group_name    = var.subnet_group_name
  security_group_ids   = var.security_group_ids[*]
  maintenance_window   = "wed:20:00-wed:21:00"

  tags = {
    Owner   = var.owner
    Env     = var.env
    datadog = var.datadog
  }
}

resource "aws_elasticache_parameter_group" "multi" {
  name   = var.memcached_name
  family = var.parameter_group_family
}

