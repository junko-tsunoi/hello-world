terraform {
  backend "s3" {
    bucket = "hekk-dev-terraform-state"
    key    = "boys-mv-crop/staging/codepipeline/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

