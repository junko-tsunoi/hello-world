terraform {
  backend "s3" {
    bucket = "hekk-dev-terraform-state"
    key    = "boys-mv-crop/staging/vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

