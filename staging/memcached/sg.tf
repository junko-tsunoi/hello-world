# module/elasticache/memcached/README.md

module "memcached_sg" {
  source = "../../../module/sg"

  security_group_name = "${local.project}-${local.env}-memcached-sgonly"
  description         = "memcached default security group"
  vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  ingress = {
    memcached = {
      from_port       = 11211
      to_port         = 11211
      protocol        = "tcp"
      cidr_blocks     = []
      self            = true
      security_groups = []
      description     = ""
    }
  }

  tags = {
    Owner = local.Owner
    Env   = local.env
    Name  = "${local.project}-${local.env}-redis-sgonly"
  }
}

output "sg_id" { value = module.memcached_sg.id }

