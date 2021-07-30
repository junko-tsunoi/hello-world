## module/elasticache/memcached/outputs.tf

output "endpoint" { value = aws_elasticache_cluster.default.cluster_address }

output "cache_nodes" {
  #value = aws_elasticache_cluster.default.cache_nodes.*.address
  value = aws_elasticache_cluster.default.cache_nodes[*].address
}
