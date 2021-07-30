resource "aws_autoscaling_group" "this" {
  name                = var.asg_name
  vpc_zone_identifier = var.vpc_zone_identifier
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  desired_capacity          = var.desired_capacity
  min_size                  = var.min_size
  max_size                  = var.max_size
  target_group_arns         = var.target_group_arns
  wait_for_capacity_timeout = 0
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]
  tags = var.tags
}

resource "aws_launch_template" "this" {
  name          = var.launch_template_name
  image_id      = data.aws_ami.this.id
  instance_type = var.instance_type
  ebs_optimized = var.ebs_optimized
  vpc_security_group_ids = var.vpc_security_group_ids
  user_data     = var.user_data_base64

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  tag_specifications {
    resource_type = "volume"
    tags = var.launch_template_tags
  }
}

data "aws_ami" "this" {
  owners = ["self"]
  dynamic "filter" {
    for_each = var.filters
    content {
      name = filter.value["name"]
      values = filter.value["values"]
    }
  }
  most_recent = true
}
