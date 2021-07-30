resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  acl           = "private"
  policy        = data.aws_iam_policy_document.default.json
  force_destroy = var.force_destroy //false in production
  versioning {
    enabled = var.versioning_enabled
  }
  lifecycle_rule {
    enabled = true
    transition {
      storage_class = "STANDARD_IA"
      days          = var.standard_ia_day
    }
    transition {
      storage_class = "GLACIER"
      days          = var.glacier_day
    }
    expiration {
      days = var.expiration_day
    }
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.region_alb[var.region]}:root"]
    }
  }
}

