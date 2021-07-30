module "acm_cf" {
  source = "../../module/acm"
  providers = {
    aws = aws.virginia
  }

  domain_name       = local.domain
  fqdn              = local.fqdn
  validation_method = "DNS"
  ttl               = 60

  tags = {
    Name  = local.fqdn
    Owner = local.Owner
    Env   = local.env
  }
}

