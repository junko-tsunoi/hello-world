locals {
  bucket = "hekk-dev-terraform-state"
}

data "terraform_remote_state" "vpc" {
  count   = var.vpc ? 1 : 0
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "boys-mv-crop/staging/vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "aurora" {
  count   = var.aurora ? 1 : 0
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "boys-mv-crop/staging/aurora/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "acm" {
  count   = var.acm ? 1 : 0
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "boys-mv-crop/staging/acm/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "s3" {
  count   = var.s3 ? 1 : 0
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "boys-mv-crop/staging/s3/terraform.tfstate"
    region = "ap-northeast-1"
  }
}


data "terraform_remote_state" "ec2" {
  count   = var.ec2 ? 1 : 0
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "boys-mv-crop/staging/ec2/main/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "batch" {
  count   = var.batch ? 1 : 0
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "boys-mv-crop/staging/ec2/batch/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "cloudfront" {
  count   = var.cloudfront ? 1 : 0
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "boys-mv-crop/staging/cloudfront/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "codedeploy" {
  count   = var.codedeploy ? 1 : 0
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "boys-mv-crop/staging/codedeploy/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

