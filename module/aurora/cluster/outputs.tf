output "cluster_id" {
  description = "List of Cluster IDs"
  value = [
    for cluster in aws_rds_cluster.this :
    cluster.id
  ]
}

locals {
  arr_endpoint = [
    for cluster in aws_rds_cluster.this :
    cluster.endpoint
  ]
  arr_reader_endpoint = [
    for cluster in aws_rds_cluster.this :
    cluster.reader_endpoint
  ]
}

output "writer_endpoint" {
  description = "List of writer endpoints"
  value       = join(",", local.arr_endpoint)
}

output "reader_endpoint" {
  description = "List of reader endpoints"
  value       = join(",", local.arr_reader_endpoint)
}
