locals {
  instance_class               = "db.t3.small"
  engine                       = "aurora-mysql"
  engine_version               = "5.7.mysql_aurora.2.09.1"
  parameter_group_family       = "aurora-mysql5.7"
  preferred_backup_window      = "19:00-20:00"
  preferred_maintenance_window = "wed:20:00-wed:21:00"
  time_zone                    = "asia/tokyo"
  master_username              = "root"
}

module "cluster" {
  source = "../../module/aurora/cluster"

  shard = 1

  apply_immediately               = true
  cluster_name                    = "${local.project}-${local.env}"
  engine                          = local.engine
  engine_version                  = local.engine_version
  engine_mode                     = "provisioned"
  port                            = 3306
  master_username                 = local.master_username
  master_password                 = random_id.master_passwd.b64_url
  db_subnet_group_name            = module.terraform_remote_state.vpc.outputs.database_subnet_group
  vpc_security_group_ids          = [ module.security_group.security_group_id ]
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  skip_final_snapshot             = false
  db_cluster_parameter_group_name = module.aurora_parameter_group.db_cluster_parameter_group_name
  storage_encrypted               = true
  backtrack_window                = 1
  backup_retention_period         = 4
  preferred_backup_window         = local.preferred_backup_window
  preferred_maintenance_window    = local.preferred_maintenance_window
  tags = {
    Project = local.project
    Owner = local.Owner
    Env   = local.env
  }
}

module "instance" {
  source = "../../module/aurora/instance"

  apply_immediately               = true //Apply database changes immediately
  cluster_identifier              = module.cluster.cluster_id
  instance_num                    = 1
  availability_zones              = [local.availability_zone[0], local.availability_zone[1], local.availability_zone[2]]
  engine                          = local.engine
  engine_version                  = local.engine_version
  instance_class                  = local.instance_class
  db_subnet_group_name            = module.terraform_remote_state.vpc.outputs.database_subnet_group
  monitoring_role_arn             = module.monitoring_iam_role.role_arn
  monitoring_interval             = 30
  db_parameter_group_name         = module.aurora_parameter_group.db_parameter_group_name
  performance_insights_enabled    = false
  tags = {
    Project = local.project
    Owner = local.Owner
    Env   = local.env
    Type  = local.instance_class
  }
}

resource "random_id" "master_passwd" {
  byte_length = 16
}

resource "random_id" "app_passwd" {
  byte_length = 16
}
