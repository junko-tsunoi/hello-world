# aws_s3_bucket.codepipeline:
resource "aws_s3_bucket" "codepipeline" {
  bucket        = "codepipeline-${local.region}-${local.project}"
  request_payer = "BucketOwner"
  tags          = {}

  versioning {
    enabled    = true
    mfa_delete = false
  }
}

# template_file.bucket_policy
data "template_file" "bucket_policy" {
  template = file("./templates/bucket_policy.json")

  vars = {
    resource = "${aws_s3_bucket.codepipeline.arn}/*"
  }
}

# aws_s3_bucket_policy.codepipeline:
resource "aws_s3_bucket_policy" "codepipeline" {
  bucket = aws_s3_bucket.codepipeline.bucket
  policy = data.template_file.bucket_policy.rendered
}

