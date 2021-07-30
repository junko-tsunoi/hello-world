## module/elasticache/redis/cluster/outputs.tf

output "endpoint" { value = aws_elasticache_replication_group.default.configuration_endpoint_address }
output "primary_endpoint" { value = aws_elasticache_replication_group.default.primary_endpoint_address }


