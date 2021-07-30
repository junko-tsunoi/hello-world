resource "aws_alb" "default" {
  name                       = var.alb_name
  security_groups            = var.security_groups[*]
  subnets                    = var.subnets[*]
  internal                   = false
  enable_deletion_protection = false
  load_balancer_type         = "application"

  dynamic "access_logs" {
    for_each = length(keys(var.access_logs)) == 0 ? [] : [var.access_logs]

    content {
      enabled = lookup(access_logs.value, "enabled", lookup(access_logs.value, "bucket", null) != null)
      bucket  = lookup(access_logs.value, "bucket", null)
      prefix  = lookup(access_logs.value, "prefix", null)
    }
  }

  tags = var.tags
}

