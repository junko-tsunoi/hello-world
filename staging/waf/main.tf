## S3 ##
module "log_bucket" {
  source = "../../module/s3/log_bucket"
  providers = {
    aws = aws.virginia
  }
  region = "us-east-1"
  #bucket_name        = "aws-waf-logs-${local.project}-${local.env}"
  bucket_name        = "aws-waf-logs-${local.project}"
  force_destroy      = false
  versioning_enabled = true
  standard_ia_day    = 30
  glacier_day        = 60
  expiration_day     = 180
  tags = {
    Owner = local.Owner
    Env   = local.env
  }
}

data "template_file" "kinesis" {
  template = file("./templates/kinesis_data_firehose_policy.json")

  vars = {
    s3_bucket_arn = module.log_bucket.s3_bucket_arn
  }
}

resource "aws_iam_policy" "waf" {
  name   = "KinesisDataFirehosePolicy-${local.Project}${local.Env}-WafLog"
  policy = data.template_file.kinesis.rendered
}

module "iam_role" {
  source = "../../module/iam/role"

  principal_service = ["firehose.amazonaws.com"]
  role_name         = "KinesisDataFirehoseRole-${local.Project}${local.Env}-WafLog"
  policy_arns = [
    aws_iam_policy.waf.arn
  ]

  tags = {
    Owner = local.Owner
    Env   = local.env
  }
}

# Kinesis
resource "aws_kinesis_firehose_delivery_stream" "waf" {
  provider    = aws.virginia
  name        = "aws-waf-logs-${local.project}-${local.env}"
  destination = "extended_s3"

  extended_s3_configuration {
    bucket_arn         = module.log_bucket.s3_bucket_arn
    role_arn           = module.iam_role.role_arn
    compression_format = "GZIP"
    prefix             = "waf_global/"
  }

  tags = {
    Name  = "aws-waf-logs-${local.project}-${local.env}"
    Owner = local.Owner
    Env   = local.env
  }
}

