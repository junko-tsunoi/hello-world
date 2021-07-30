locals {
  aws_account    = "development"
  aws_account_id = "174260878857"
  Owner          = "PresidentRoom"
  owner          = "presidentroom"
  project        = "boys-findyourstar"
  Project        = "BoysFindyourstar"
  env            = "stg"
  Env            = "stg"
  region         = "ap-northeast-1"
  availability_zone = [
    "ap-northeast-1a",
    "ap-northeast-1c",
    "ap-northeast-1d"
  ]
  domain = "findyourstar.jp"
  fqdn   = "stg.findyourstar.jp"
}
