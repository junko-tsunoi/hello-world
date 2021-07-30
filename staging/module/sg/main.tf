resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = var.description
  vpc_id      = var.vpc_id
  tags        = var.tags

  dynamic "ingress" {
    for_each = var.ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      self        = ingress.value.self
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

