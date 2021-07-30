output "vpc_id" { value = module.vpc.vpc_id }
output "public_subnets" { value = module.vpc.public_subnets }
output "protected_subnets" { value = module.vpc.protected_subnets }
output "public_subnets_cidr_blocks" { value = module.vpc.public_subnets_cidr_blocks }
output "database_subnet_group" { value = module.vpc.database_subnet_group }
output "elasticache_subnet_group_name" { value = module.vpc.elasticache_subnet_group_name }
output "default_security_group_id" { value = module.vpc.default_security_group_id }
