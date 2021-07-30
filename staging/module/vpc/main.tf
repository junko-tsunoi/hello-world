module "vpc" {

  source = "terraform-aws-modules/vpc/aws"

  name                  = "${var.name}-vpc"
  cidr                  = var.cidr
  azs                   = var.availability_zones[*]
  public_subnets        = var.public_subnets[*]
  private_subnets       = var.protected_subnets[*]
  database_subnets      = var.database_subnets[*]
  elasticache_subnets   = var.elasticache_subnets[*]
  private_subnet_suffix = "protected"
  intra_subnet_suffix   = "private"
  enable_nat_gateway    = var.enable_nat_gateway
  single_nat_gateway    = var.single_nat_gateway

  tags = var.vpc_tags
}

resource "aws_default_security_group" "this" {
  vpc_id = module.vpc.vpc_id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.sg_tags
}

