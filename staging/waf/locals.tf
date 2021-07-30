locals {
  aws_account    = "development"
  aws_account_id = "174260878857"
  Owner          = "PresidentRoom"
  owner          = "presidentroom"
  project        = "boys-mv-crop"
  Project        = "BoysMvCrop"
  env            = "stg"
  Env            = "Stg"
  region         = "ap-northeast-1"
  availability_zone = [
    "ap-northeast-1a",
    "ap-northeast-1c",
    "ap-northeast-1d"
  ]
  domain = "stg.moment.ensemble-stars.jp"
  fqdn   = "stg.moment.ensemble-stars.jp"
}
