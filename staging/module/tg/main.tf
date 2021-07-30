resource "aws_alb_listener" "this" {
  load_balancer_arn = var.alb_arn
  port              = var.listen_port
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "403 forbidden"
      status_code  = "403"
    }
  }
  lifecycle {
    ignore_changes = [
      port,
      default_action
    ]
  }
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = aws_alb_listener.this.arn
  priority     = 1

  action {
    target_group_arn = aws_alb_target_group.this.arn
    type             = "forward"
  }
  condition {
    dynamic "http_header" {
      for_each = { for i in var.condition : i.field => i if i.field == "http_header" }
      content {
        http_header_name = http_header.value["http_header_name"]
        values           = http_header.value["value"]
      }
    }
  }

  lifecycle {
    ignore_changes = [
      action
    ]
  }
}

resource "aws_alb_target_group" "this" {
  name                 = var.alb_target_group_name
  port                 = var.target_group_port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay
  target_type          = var.target_type

  health_check {
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = "HTTP"
    timeout             = var.health_check_timeout
    unhealthy_threshold = var.unhealthy_threshold
    healthy_threshold   = var.healthy_threshold
    matcher             = var.health_check_matcher
  }
  tags = var.tags
}
