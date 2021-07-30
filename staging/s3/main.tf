module "default" {
  source = "../../module/s3/general"

  bucket_name = "${local.project}-${local.env}"
  tags = {
    Owner = local.Owner
    Env   = local.env
    Name  = "${local.project}-${local.env}"
  }
}

