module "security_group" {
  source = "../../module/sg"

  security_group_name = "${local.project}-${local.env}-mysql-sgonly"
  description         = "mysql and aurora default security group"
  vpc_id              = module.terraform_remote_state.vpc.outputs.vpc_id
  ingress = {
    mysql = {
      from_port       = 3306
      to_port         = 3306
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = []
      self            = true
      description     = ""
    }
  }

  tags = {
    Owner = local.Owner
    Env   = local.env
    Name  = "${local.project}-${local.env}-mysql-sgonly"
  }
}
