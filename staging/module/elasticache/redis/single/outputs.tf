## module/elasticache/redis/single/outputs.tf

output "endpoint" { value = aws_elasticache_cluster.single.cache_nodes.0.address }

