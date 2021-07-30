module "vpc" {
  source = "../../module/vpc"

  name               = "${local.project}-${local.env}"
  enable_nat_gateway = true
  single_nat_gateway = true

  cidr               = "192.168.0.0/16"
  availability_zones = local.availability_zone
  public_subnets = [
    "192.168.0.0/24",
    "192.168.1.0/24",
    "192.168.2.0/24"
  ]
  protected_subnets = [
    "192.168.10.0/24",
    "192.168.11.0/24",
    "192.168.12.0/24",
  ]
  database_subnets = [
    "192.168.20.0/24",
    "192.168.21.0/24",
    "192.168.22.0/24"
  ]
  elasticache_subnets = [
    "192.168.30.0/24",
    "192.168.31.0/24",
    "192.168.32.0/24"
  ]

  vpc_tags = {
    Owner = local.Owner
    Env   = local.env
  }

  sg_tags = {
    Name  = "${local.project}-${local.env}-default"
    Owner = local.Owner
    Env   = local.env
  }
}

