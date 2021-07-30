# AWS Application and Network Load Balancer (ALB & NLB) Terraform module

## Usage
```
module "alb" {
  source = "../../../module/alb"

  alb_name = "${local.project}-${local.env}-alb"
  security_groups = [
    module.alb_security_group.security_group_id,
    module.default_security_group.security_group_id
  ]
  subnets = [
    module.terraform_remote_state.vpc.outputs.public_subnets[0],
    module.terraform_remote_state.vpc.outputs.public_subnets[1],
    module.terraform_remote_state.vpc.outputs.public_subnets[2]
  ]

  access_logs = {
    bucket = module.log_s3_bucket.s3_bucket_id
    enabled = true
  }

  tags = {
    Owner = local.Owner
    Env   = local.env
    Name  = "${local.project}-${local.env}-alb"
  }
}
```

