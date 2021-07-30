# module/elasticache/memcached/README.md

locals {
  node_type = "cache.t3.micro"
  engine    = "memcached"
}

## memcached ##
module "memcached" {
  source = "../../../module/elasticache/memcached"

  cluster_id             = "${local.project}-${local.env}-memcached"
  engine                 = local.engine
  node_type              = local.node_type
  num_cache_nodes        = 1
  az_mode                = "single-az"
  availability_zone      = [local.availability_zone[1]]
  port                   = 11211
  subnet_group_name      = data.terraform_remote_state.vpc.outputs.elasticache_subnet_group_name
  security_group_ids     = module.memcached_sg.id
  parameter_group_name   = "${local.project}-${local.env}-memcached"
  parameter_group_family = "memcached1.5"
  maintenance_window     = "wed:20:00-wed:21:00"
  apply_immediately      = true

  tags = {
    Owner = local.Owner
    Env   = local.env
    Type  = local.node_type
    Group = local.engine
    Name  = "${local.project}-${local.env}-memcached"
  }
}

output "endpoint" { value = module.memcached.endpoint }
output "cache_nodes" { value = module.memcached.cache_nodes }

