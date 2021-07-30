terraform {
  backend "s3" {
    bucket = "hekk-dev-terraform-state"
    key    = "boys-mv-crop/staging/ec2/batch/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

