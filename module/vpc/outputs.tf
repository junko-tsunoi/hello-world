output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = module.vpc.default_security_group_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "public_subnets_cidr_blocks" {
  description = "List of ARNs of public subnets"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "protected_subnets" {
  description = "List of IDs of orotected subnets"
  value       = module.vpc.private_subnets
}

output "database_subnet_group" {
  description = "ID of database subnet group"
  value       = module.vpc.database_subnet_group
}

output "elasticache_subnet_group_name" {
  description = "Name of elasticache subnet group"
  value       = module.vpc.elasticache_subnet_group_name
}
