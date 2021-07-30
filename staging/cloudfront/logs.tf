module "log_bucket" {
  source = "../../module/s3/log_bucket"

  region             = local.region
  bucket_name        = "${local.project}-${local.env}-cf-log"
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

