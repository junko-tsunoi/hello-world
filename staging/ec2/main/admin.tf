locals {
  use = "admin"
}

resource "aws_eip" "admin" {
  vpc = true
  tags = {
    "Env"   = local.env
    "Name"  = "${local.project}-${local.env}-${local.use}"
    "Owner" = local.Owner
  }
}

data "template_file" "user_data" {
  template = file("./templates/user_data.sh")
  vars = {
    eip_alloc_id = aws_eip.admin.id
  }
}

module "admin_autoscaling_group" {
  source = "../../../module/autoscaling"

  asg_name             = "${local.project}-${local.env}-${local.use}"
  launch_template_name = "${local.project}-${local.env}-${local.use}"
  instance_type        = "t3.small"
  vpc_zone_identifier  = module.terraform_remote_state.vpc.outputs.public_subnets
  desired_capacity     = 1
  min_size             = 1
  max_size             = 1
  target_group_arns    = [module.target_group.target_group_arn]
  vpc_security_group_ids = [
    module.default_security_group.security_group_id,
    module.ssh_security_group.security_group_id,
    module.terraform_remote_state.aurora.outputs.security_group_id,
  ]
  iam_instance_profile_name = module.iam_role.role_name
  ebs_optimized             = true
  user_data_base64          = base64encode(data.template_file.user_data.rendered)

  filters = [
    {
      name   = "state"
      values = ["available"]
    },
    {
      name   = "tag:Name"
      values = ["${local.project}-${local.env}"]
    },
    {
      name   = "tag:Env"
      values = [local.env]
    },
    {
      name   = "tag:Created"
      values = ["packer"]
    }
  ]

  tags = [
    {
      key                 = "Name"
      value               = "${local.project}-${local.env}-${local.use}"
      propagate_at_launch = true
    },
    {
      key                 = "Env"
      value               = local.env
      propagate_at_launch = true
    },
    {
      key                 = "Owner"
      value               = local.Owner
      propagate_at_launch = true
    },
    {
      key                 = "Type"
      value               = "t3.small"
      propagate_at_launch = true
    }
  ]

  launch_template_tags = {
    Project = local.project
    Owner   = local.Owner
    Env     = local.env
    Name    = "${local.project}-${local.env}-${local.use}"
    Backup  = true
  }
}

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
