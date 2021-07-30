output "security_group_id" {
  value = module.security_group.security_group_id
}

output "writer_endpoint" {
  value = module.cluster.writer_endpoint
}

output "reader_endpoint" {
  value = module.cluster.reader_endpoint
}
