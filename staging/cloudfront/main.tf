locals {
  alb_dns_name = module.terraform_remote_state.ec2.outputs.alb_dns_name
  #web_acl_id   = "arn:aws:wafv2:us-east-1:174260878857:global/webacl/BoysFindYourStarStg/75f72f54-2c7c-4696-8e52-6dc2f8837b9a"
  web_acl_id = ""
  ordered_cache_behavior = [
    {
      path_pattern     = "/assets/video/*"
      target_origin_id = "S3-${module.terraform_remote_state.s3.outputs.s3_bucket_id}"
      forwarded_values_headers = []
    },
    {
      path_pattern     = "/assets/images/*"
      target_origin_id = "ELB-${module.terraform_remote_state.ec2.outputs.alb_name}"
      forwarded_values_headers = [ "*" ]
    },
    {
      path_pattern     = "/upload/*"
      target_origin_id = "S3-${module.terraform_remote_state.s3.outputs.s3_bucket_id}"
      forwarded_values_headers = []
    }
  ]
}

data "aws_iam_policy_document" "main" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.terraform_remote_state.s3.outputs.s3_bucket_arn}/*"]

    principals {
      type = "AWS"
      identifiers = [
        aws_cloudfront_origin_access_identity.main.iam_arn,
      ]
    }
  }
  statement {
    actions = [
      "s3:DeleteObject",
      "s3:PutObject",
    ]
    resources = ["${module.terraform_remote_state.s3.outputs.s3_bucket_arn}/*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::174260878857:user/boys.mv.crop"
      ]
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "main" {
  comment = "access-identity-${local.project}.s3.amazonaws.com"
}

resource "aws_s3_bucket_policy" "main" {
  bucket = module.terraform_remote_state.s3.outputs.s3_bucket_id
  policy = data.aws_iam_policy_document.main.json
}

resource "aws_cloudfront_distribution" "main" {
  aliases = [
    local.fqdn,
  ]
  comment          = "Created with terraform"
  enabled          = true
  http_version     = "http2"
  is_ipv6_enabled  = false
  price_class      = "PriceClass_All"
  retain_on_delete = false
  tags = {
    "Env"   = local.env
    "Owner" = local.Owner
  }
  wait_for_deployment = true

  origin {
    domain_name = local.alb_dns_name
    origin_id   = "ELB-${module.terraform_remote_state.ec2.outputs.alb_name}"

    custom_header {
      name  = "X-Pre-Shared-Key"
      value = local.alb_dns_name
    }

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "https-only"
      origin_read_timeout      = 60
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
    }
  }

  default_cache_behavior {
    allowed_methods = [
      "DELETE",
      "GET",
      "HEAD",
      "OPTIONS",
      "PATCH",
      "POST",
      "PUT",
    ]
    cached_methods = [
      "GET",
      "HEAD",
    ]
    compress               = true
    default_ttl            = 1
    max_ttl                = 1
    min_ttl                = 0
    smooth_streaming       = false
    target_origin_id       = "ELB-${module.terraform_remote_state.ec2.outputs.alb_name}"
    trusted_signers        = []
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      headers = [
        "*",
      ]
      query_string            = true
      query_string_cache_keys = []

      cookies {
        forward           = "all"
        whitelisted_names = []
      }
    }
  }

  origin {
    domain_name = module.terraform_remote_state.s3.outputs.s3_bucket_domain_name
    origin_id   = "S3-${module.terraform_remote_state.s3.outputs.s3_bucket_id}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
    }
  }

  dynamic ordered_cache_behavior {
    for_each = local.ordered_cache_behavior
    content {
      allowed_methods = [
        "GET",
        "HEAD",
      ]
      cached_methods = [
        "GET",
        "HEAD",
      ]
      compress               = true
      default_ttl            = 1
      max_ttl                = 1
      min_ttl                = 0
      path_pattern           = ordered_cache_behavior.value["path_pattern"]
      smooth_streaming       = false
      target_origin_id       = ordered_cache_behavior.value["target_origin_id"]
      trusted_key_groups     = []
      trusted_signers        = []
      viewer_protocol_policy = "redirect-to-https"

      forwarded_values {
        headers                 = ordered_cache_behavior.value["forwarded_values_headers"]
        query_string            = false
        query_string_cache_keys = []

        cookies {
          forward           = "none"
          whitelisted_names = []
        }
      }
    }
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = module.terraform_remote_state.acm.outputs.acm_cf_arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.1_2016"
    ssl_support_method             = "sni-only"
  }

  web_acl_id = local.web_acl_id
}

