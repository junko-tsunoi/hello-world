# module/elasticache/redis/README.md

## Usage
```

### redis single mode ##
#module "redis-single" {
#  source      = "../module/elasticache/redis/single"
#
#  owner                  = local.Owner
#  env                    = local.Env
#  datadog                = local.datadog
#  redis_name             = "${local.project}-${local.env}-redis"
#  engine                 = "redis"
#  node_type              = "cache.t3.medium"
#  num_cache_nodes        = 1
#  availability_zone      = local.availability_zone[0]
#  port                   = 6379
#  subnet_group_name      = data.terraform_remote_state.vpc.outputs.elasticache_subnet_group_name
#  security_group_ids     = module.redis-sg.id
#  parameter_group_family = "redis5.0"
#}
#
#output "endpoint" { value = module.redis-single.endpoint }

### redis replication mode ##
#module "redis-replica" {
#  source      = "../module/elasticache/redis/replica"
#
#  owner                    = local.Owner
#  env                      = local.Env
#  datadog                  = local.datadog
#  replica_name             = "${local.project}-${local.env}-redis-replica"
#  engine                   = "redis"
#  description              = "Created by Terraform."
#  node_type                = "cache.t3.medium"
#  port                     = 6379
#  subnet_group_name        = data.terraform_remote_state.vpc.outputs.elasticache_subnet_group_name
#  security_group_ids       = module.redis-sg.id
#  parameter_group_family   = "redis5.0"
#  number_cache_clusters    = 2 # 2(master,replica), 3(master,replica x2)
#  snapshot_retention_limit = 0 # 0,Invalid 1~,Valid days
#}
#
#output "endpoint" { value = module.redis-replica.endpoint }

### redis cluster mode ##snapshot not recommended
#module "redis-cluster" {
#  source      = "../module/elasticache/redis/cluster"
#
#  owner                   = local.Owner
#  env                     = local.Env
#  datadog                 = local.datadog
#  cluster_name            = "${local.project}-${local.env}-redis-cluster"
#  engine                  = "redis"
#  description             = "Created by Terraform."
#  node_type               = "cache.t3.medium"
#  port                    = 6379
#  subnet_group_name       = data.terraform_remote_state.vpc.outputs.elasticache_subnet_group_name
#  security_group_ids      = module.redis-sg.id
#  parameter_group_name    = "default.redis5.0.cluster.on"
#  num_node_groups         = 2 #Shard number
#  replicas_per_node_group = 1 #Number of replicas
#}
#
#output "endpoint" { value = module.redis-cluster.endpoint }


module "redis-sg" {
  source    = "../module/sg"

  security_group_name = "${local.project}-${local.env}-redis-sgonly"
  owner               = local.Owner
  env                 = local.Env
  description         = "redis default security group"
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  ingress     = {
    redis = {
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      cidr_blocks = []
      self        = true
    }
  }
}

output "id" { value = module.redis-sg.id }
```
