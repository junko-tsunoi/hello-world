# Target Group of AWS Application Load Balancer Terraform module

## Usage
```
module "target_group" {
  source = "../../module/tg"

  certificate_arn       = module.terraform_remote_state.acm.outputs.acm_alb_arn
  #xpre_shared_key       = module.alb.alb_dns_name
  alb_arn     = module.alb.alb_arn
  listen_port           = 443
  alb_target_group_name = "${local.project}-${local.env}-tg"
  target_group_port     = 80
  vpc_id                = module.terraform_remote_state.vpc.outputs.vpc_id
  target_type           = "instance"
  ssl_policy            = "ELBSecurityPolicy-2016-08"
  deregistration_delay  = 30
  health_check_interval = 30
  health_check_path     = "/"
  health_check_port     = 80
  health_check_timeout  = 5
  unhealthy_threshold   = 2
  healthy_threshold     = 2
  health_check_matcher  = "200,302"

  condition = [
    {
      field            = "http_header"
      http_header_name = "X-Pre-Shared-Key"
      value = [
        module.alb.alb_dns_name
      ]
    }
  ]

  tags = {
    Project = local.project
    Owner = local.Owner
    Env   = local.env
    Name  = "${local.project}-${local.env}-alb"
  }
}
```
