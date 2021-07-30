resource "aws_rds_cluster" "this" {
  count = var.shard

  apply_immediately = var.apply_immediately

  cluster_identifier              = "${var.cluster_name}-${format("${var.prefix_name}%02d", count.index + 1)}"
  vpc_security_group_ids          = var.vpc_security_group_ids[*]
  engine                          = var.engine
  engine_version                  = var.engine_version
  engine_mode                     = var.engine_mode
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  master_username                 = var.master_username
  master_password                 = var.master_password
  copy_tags_to_snapshot           = true
  db_subnet_group_name            = var.db_subnet_group_name
  port                            = 3306
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  backtrack_window                = var.backtrack_window
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  storage_encrypted               = var.storage_encrypted

  skip_final_snapshot = var.skip_final_snapshot
  deletion_protection = var.deletion_protection
  iam_roles           = var.iam_roles

  tags = var.tags

  lifecycle {
    ignore_changes = [
      master_username,
      master_password
    ]
  }
}

