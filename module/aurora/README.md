# AWS RDS Aurora Terraform module

## Usage
### cluster
```
module "cluster" {
  source = "../../../module/aurora/cluster"

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
  vpc_security_group_ids          = [ module.security_group.id ]
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
```

### instance
```
module "instance" {
  source = "../../../module/aurora/instance"

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
```

### parameter_group
```
module "aurora_parameter_group" {
  source = "../../../module/aurora/parameter_group"

  db_parameter_group_name      = "${local.project}-${local.env}"
  db_cluster_parameter_group_name = "${local.project}-${local.env}-cluster"
  parameter_group_family         = local.parameter_group_family

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    },
    {
      name  = "character_set_connection"
      value = "utf8mb4"
    },
    {
      name  = "character_set_database"
      value = "utf8mb4"
    },
    {
      name  = "character_set_results"
      value = "utf8mb4"
    },
    {
      name  = "collation_connection"
      value = "utf8mb4_bin"
    },
    {
      name  = "collation_server"
      value = "utf8mb4_bin"
    },
    {
      name  = "slow_query_log"
      value = "1"
    },
    {
      name  = "long_query_time"
      value = "0.1"
    },
    {
      name  = "time_zone"
      value = local.time_zone
    },
    {
      name  = "max_error_count"
      value = 65535
    },
    {
      name  = "max_connections"
      value = "1"
    }
  ]
  tags = {
    Project = local.project
    Owner = local.Owner
    Env   = local.env
  }
}
```
