## module/elasticache/memcached/single/outputs.tf

output "endpoint" { value = aws_elasticache_cluster.defalut.cluster_address }

