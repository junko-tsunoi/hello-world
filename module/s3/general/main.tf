resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  request_payer = "BucketOwner"
  acl           = var.acl
  force_destroy = var.force_destroy

  versioning {
    enabled    = var.versioning
    mfa_delete = var.mfa_delete
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}
