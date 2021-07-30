module "ssh_security_group" {
  source = "../../../module/sg"

  security_group_name = "${local.project}-${local.env}-${local.use}-sg"
  description         = "ec2 admin security group"
  vpc_id              = module.terraform_remote_state.vpc.outputs.vpc_id
  ingress = {
    ssh = {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr_blocks = [
        "116.91.136.230/32", // hekk(main)
        "113.37.105.250/32", // hekk(sub)
        "153.150.19.8/29",   // spookies
        "123.226.227.160/32" //spookies
      ]
      security_groups = []
      self            = true
      description     = ""
    }
  }

  tags = {
    Owner = local.Owner
    Env   = local.env
    Name  = "${local.project}-${local.env}-${local.use}-sg"
  }
}
