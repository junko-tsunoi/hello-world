## module/elasticache/memcached/single/main.tf

resource "aws_elasticache_cluster" "defalut" {
  cluster_id           = var.memcached_name
  engine               = var.engine
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = aws_elasticache_parameter_group.default.name
  port                 = var.port
  subnet_group_name    = var.subnet_group_name
  security_group_ids   = var.security_group_ids[*]
  maintenance_window   = "wed:20:00-wed:21:00"
  availability_zone    = var.availability_zone

  tags = {
    Owner   = var.owner
    Env     = var.env
    datadog = var.datadog
  }
}

resource "aws_elasticache_parameter_group" "default" {
  name   = var.memcached_name
  family = var.parameter_group_family
}

