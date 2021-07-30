resource "aws_db_parameter_group" "this" {
  name   = var.db_parameter_group_name
  family = var.parameter_group_family
  tags   = var.tags
}

resource "aws_rds_cluster_parameter_group" "this" {
  name   = var.db_cluster_parameter_group_name
  family = var.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = var.apply_method
    }
  }

  tags = var.tags
}

