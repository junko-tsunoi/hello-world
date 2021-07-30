## module/elasticache/redis/single/main.tf

resource "aws_elasticache_cluster" "single" {
  cluster_id           = var.redis_name
  engine               = var.engine
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = aws_elasticache_parameter_group.default.name
  port                 = var.port
  subnet_group_name    = var.subnet_group_name
  security_group_ids   = var.security_group_ids[*]
  maintenance_window   = "wed:19:00-wed:20:00"
  availability_zone    = var.availability_zone

  tags = {
    Owner   = var.owner
    Env     = var.env
    Type    = var.node_type
    datadog = var.datadog
  }
}

resource "aws_elasticache_parameter_group" "default" {
  name   = var.redis_name
  family = var.parameter_group_family
}

