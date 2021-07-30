# AWS Auto Scaling Group (ASG) Terraform module

## Usage
```
module "autoscaling_group" {
  source = "../../../module/autoscaling"

  asg_name             = "${local.project}-${local.env}"
  launch_template_name = "${local.project}-${local.env}"
  instance_type        = "t3.small"
  vpc_zone_identifier  = module.terraform_remote_state.vpc.outputs.protected_subnets
  desired_capacity     = 0
  min_size             = 0
  max_size             = 1
  target_group_arns    = [module.target_group.target_group_arn]
  vpc_security_group_ids = [
    module.default_security_group.security_group_id,
    module.terraform_remote_state.aurora.outputs.security_group_id,
  ]
  iam_instance_profile_name = module.ec2_iam_role.role_name
  ebs_optimized             = true

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
      value               = "${local.project}-${local.env}"
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
    Name    = "${local.project}-${local.env}"
    Backup  = true
  }
}
```

