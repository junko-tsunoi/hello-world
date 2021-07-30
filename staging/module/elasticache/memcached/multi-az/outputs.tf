## module/elasticache/memcached/multi-az/outputs.tf

output "endpoint" { value = aws_elasticache_cluster.multi.cluster_address }

