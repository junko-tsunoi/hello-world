# AWS S3 bucket Terraform module (logs)

## Usage
```
module "log_bucket" {
  source = "../../../module/s3/log_bucket"

  bucket_name        = "${local.project}-${local.env}-app-logs"
  region             = local.region
  force_destroy      = false
  versioning_enabled = true
  standard_ia_day    = 30
  glacier_day        = 60
  expiration_day     = 180
  tags = {
    Project = local.project
    Owner   = local.Owner
    Env     = local.env
    Name    = "${local.project}-${local.env}-app-logs"
  }
}
```
