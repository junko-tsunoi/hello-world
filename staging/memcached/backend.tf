terraform {
  backend "s3" {
    bucket = "hekk-dev-terraform-state"
    key    = "boys-findyourstar/staging/memcached/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

