# data.aws_route53_zone.default
data "aws_route53_zone" "default" {
  name = local.fqdn
}

# aws_route53_record.default:
resource "aws_route53_record" "default" {
  name    = ""
  type    = "A"
  zone_id = data.aws_route53_zone.default.zone_id

  alias {
    evaluate_target_health = false
    name                   = module.terraform_remote_state.cloudfront.outputs.cf_domain_name
    zone_id                = module.terraform_remote_state.cloudfront.outputs.cf_hosted_zone_id
  }
}

# aws_route53_health_check.creative_report:
resource "aws_route53_health_check" "default" {
  child_health_threshold = 0
  child_healthchecks     = []
  enable_sni             = true
  failure_threshold      = 3
  fqdn                   = aws_route53_record.default.fqdn
  invert_healthcheck     = false
  measure_latency        = true
  port                   = 443
  regions = [
    "ap-northeast-1",
    "ap-southeast-1",
    "ap-southeast-2",
  ]
  request_interval = 30
  resource_path    = "/"
  tags = {
    Name  = aws_route53_record.default.fqdn
    Owner = local.Owner
    Env   = local.env
  }
  type = "HTTPS"
}
