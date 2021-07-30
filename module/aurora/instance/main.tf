resource "aws_rds_cluster_instance" "this" {

  count = length(var.cluster_identifier) * var.instance_num

  apply_immediately            = var.apply_immediately
  identifier                   = "${element(var.cluster_identifier, count.index % length(var.cluster_identifier))}-${format("%02d", floor(count.index / length(var.cluster_identifier) + 1))}"
  cluster_identifier           = element(var.cluster_identifier, count.index % length(var.cluster_identifier))
  availability_zone            = element(var.availability_zones, floor(count.index / length(var.cluster_identifier) + 1))
  engine                       = var.engine
  engine_version               = var.engine_version
  instance_class               = var.instance_class
  db_subnet_group_name         = var.db_subnet_group_name
  db_parameter_group_name      = var.db_parameter_group_name
  monitoring_role_arn          = var.monitoring_role_arn
  monitoring_interval          = var.monitoring_interval
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  performance_insights_enabled = var.performance_insights_enabled

  tags = var.tags
}
