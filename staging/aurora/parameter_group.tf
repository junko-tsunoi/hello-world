module "aurora_parameter_group" {
  source = "../../module/aurora/parameter_group"

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
      value = "500"
    }
  ]
  tags = {
    Project = local.project
    Owner = local.Owner
    Env   = local.env
  }
}
