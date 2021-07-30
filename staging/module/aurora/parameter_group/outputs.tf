output "db_cluster_parameter_group_name" {
  description = "The name of a DB Cluster parameter group to use"
  value       = aws_rds_cluster_parameter_group.this.name
}

output "db_parameter_group_name" {
  description = "The name of a DB parameter group to use"
  value       = aws_db_parameter_group.this.name
}

