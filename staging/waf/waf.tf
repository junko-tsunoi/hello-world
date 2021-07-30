resource "aws_wafv2_web_acl" "default" {
  provider = aws.virginia
  name     = "BoysMvCropStgACL"
  scope    = "CLOUDFRONT"
  tags     = {}
  tags_all = {}

  default_action {

    block {
      custom_response {
        response_code = 302

        response_header {
          name  = "Location"
          value = "https://ensemble-stars.jp/"
        }
      }
    }
  }

  rule {
    name     = "WhiteIpSetRuleHekk"
    priority = 2

    action {
      allow {
      }
    }

    statement {

      ip_set_reference_statement {
        arn = "arn:aws:wafv2:us-east-1:174260878857:global/ipset/hekk-ip-set/391a43a6-a8b0-4183-a900-7a806e965fc4"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WhiteIpSetRuleHekk"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "WhiteIpSetRuleSpookies"
    priority = 1

    action {
      allow {
      }
    }

    statement {

      ip_set_reference_statement {
        arn = "arn:aws:wafv2:us-east-1:174260878857:global/ipset/spokes-ip-set/5291b211-2727-406a-92e0-fafd9ca3ea65"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WhiteIpSetRuleSpookies"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "AWS-AWSManagedRulesPHPRuleSet"
    priority = 0

    override_action {

      none {}
    }

    statement {

      managed_rule_group_statement {
        name        = "AWSManagedRulesPHPRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesPHPRuleSet"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "BoysMvCropStgACL"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_web_acl_logging_configuration" "default" {
  provider = aws.virginia
  log_destination_configs = [ aws_kinesis_firehose_delivery_stream.waf.arn ]
  resource_arn            = aws_wafv2_web_acl.default.arn
}
