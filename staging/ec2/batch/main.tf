locals {
  use = "batch"
  Use = "Batch"
}

resource "aws_eip" "batch" {
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
    eip_alloc_id = aws_eip.batch.id
  }
}

module "autoscaling_group" {
  source = "../../../module/autoscaling"

  asg_name             = "${local.project}-${local.env}-${local.use}"
  launch_template_name = "${local.project}-${local.env}-${local.use}"
  instance_type        = "t3.small"
  vpc_zone_identifier  = module.terraform_remote_state.vpc.outputs.public_subnets
  desired_capacity     = 1
  min_size             = 1
  max_size             = 1
  vpc_security_group_ids = [
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
      values = ["${local.project}-${local.env}-${local.use}"]
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

