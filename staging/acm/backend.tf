terraform {
  backend "s3" {
    bucket = "hekk-dev-terraform-state"
    key    = "boys-mv-crop/staging/acm/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

