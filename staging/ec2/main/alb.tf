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
    bucket  = module.log_s3_bucket.s3_bucket_id
    enabled = true
  }

  tags = {
    Owner = local.Owner
    Env   = local.env
    Name  = "${local.project}-${local.env}-alb"
  }
}

module "target_group" {
  source = "../../../module/tg"

  certificate_arn = module.terraform_remote_state.acm.outputs.acm_alb_arn
  #xpre_shared_key       = module.alb.alb_dns_name
  alb_arn               = module.alb.alb_arn
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
    Owner   = local.Owner
    Env     = local.env
    Name    = "${local.project}-${local.env}-alb"
  }
}

module "alb_security_group" {
  source = "../../../module/sg"

  security_group_name = "${local.project}-${local.env}-alb-sg"
  description         = "alb default security group"
  vpc_id              = module.terraform_remote_state.vpc.outputs.vpc_id
  ingress = {
    https = {
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      self            = false
      description     = ""
    }
  }
  tags = {
    Owner = local.Owner
    Env   = local.env
    Name  = "${local.project}-${local.env}-alb-sg"
  }
}

module "log_s3_bucket" {
  source = "../../../module/s3/log_bucket"

  bucket_name        = "${local.project}-${local.env}-app-logs"
  region             = local.region
  force_destroy      = false
  versioning_enabled = true
  standard_ia_day    = 30
  glacier_day        = 60
  expiration_day     = 180
  tags = {
    Owner = local.Owner
    Env   = local.env
    Name  = "${local.project}-${local.env}-app-logs"
  }
}

