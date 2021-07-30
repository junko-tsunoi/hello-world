module "terraform_remote_state" {
  source = "../terraform_remote_state"
  ec2    = true
  s3     = true
  acm    = true
}
