# AWS VPC Terraform module
# Usage
```
module "vpc" {
  source                = "../module/vpc"

  owner                 = local.Owner
  env                   = local.Env

  vpc_name                    = "${local.project}-${local.env}-vpc"
  igw_name                    = "${local.project}-${local.env}-igw"
  default_security_group_name = "${local.project}-${local.env}-default"

  cidr_block            = "172.27.0.0/16"
  availability_zones    = local.availability_zone
  public-cidr_blocks    = [
                             "172.27.0.0/24"
                            ,"172.27.1.0/24"
                            ,"172.27.2.0/24"
                          ]
  protected-cidr_blocks = [
                             "172.27.10.0/24"
                            ,"172.27.11.0/24"
                            ,"172.27.12.0/24"
                          ]
  db-cidr_blocks        = [
                             "172.27.20.0/24"
                            ,"172.27.21.0/24"
                            ,"172.27.22.0/24"
                          ]
  ec-cidr_blocks        = [
                             "172.27.30.0/24"
                            ,"172.27.31.0/24"
                            ,"172.27.32.0/24"
                          ]

  enable_nat_gateway    = true
  single_nat_gateway    = true
}
```

## Terraform AWS Modules
https://github.com/terraform-aws-modules/terraform-aws-vpc
