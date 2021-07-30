terraform {
  backend "s3" {
    bucket = "hekk-dev-terraform-state"
    key    = "boys-mv-crop/staging/aurora/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

