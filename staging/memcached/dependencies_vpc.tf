data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "hekk-dev-terraform-state"
    key    = "boys-findyourstar/staging/vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "acm" {
  backend = "s3"
  config = {
    bucket = "hekk-dev-terraform-state"
    key    = "boys-findyourstar/staging/acm/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
