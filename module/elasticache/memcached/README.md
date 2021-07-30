# module/elasticache/memcached/README.md

## Usage
```
# memcached.tpl

### memcached single-az mode ##
#module "memcached" {
#  source      = "../module/elasticache/memcached/single"
#
#  owner                  = local.Owner
#  env                    = local.Env
#  datadog                = local.datadog
#  memcached_name         = "${local.project}-${local.env}-memcached"
#  engine                 = "memcached"
#  node_type              = "cache.t3.micro"
#  num_cache_nodes        = 1
#  availability_zone      = local.availability_zone[0]
#  port                   = 11211
#  subnet_group_name      = data.terraform_remote_state.vpc.outputs.elasticache_subnet_group_name
#  security_group_ids     = module.memcached-sg.id
#  parameter_group_family = "memcached1.5"
#}
#
#output "endpoint" { value = module.memcached.endpoint }

### memcached multi-az mode ##
#module "memcached_multi" {
#  source      = "../module/elasticache/memcached/multi-az"
#
#  owner                  = local.Owner
#  env                    = local.Env
#  datadog                = local.datadog
#  memcached_name         = "${local.project}-${local.env}-memcached-az"
#  engine                 = "memcached"
#  node_type              = "cache.t3.micro"
#  num_cache_nodes        = 2
#  az_mode                = "cross-az"
#  port                   = 11211
#  subnet_group_name      = data.terraform_remote_state.vpc.outputs.elasticache_subnet_group_name
#  security_group_ids     = module.memcached-sg.id
#  parameter_group_family = "memcached1.5"
#}
#
#output "endpoint" { value = module.memcached_multi.endpoint }

module "memcached-sg" {
  source    = "../module/sg"

  security_group_name = "${local.project}-${local.env}-memcached-sgonly"
  owner               = local.Owner
  env                 = local.Env
  description         = "memcached default security group"
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  ingress     = {
    memcached = {
      from_port   = 11211
      to_port     = 11211
      protocol    = "tcp"
      cidr_blocks = []
      self        = true
    }
  }
}

output "id" { value = module.memcached-sg.id }
```
