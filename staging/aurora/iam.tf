module "monitoring_iam_role" {
  source = "../../module/iam/role"

  principal_service = ["monitoring.rds.amazonaws.com"]
  role_name         = "${local.Project}${local.Env}AuroraMonitoringRole"
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
  ]

  tags = {
    Owner = local.Owner
    Env   = local.env
  }
}
