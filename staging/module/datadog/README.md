# module/datadog/README.md

## Usage
```
provider "datadog" {
  //infra-dev: infra+dev
  api_key = ""
  app_key = ""
}

module "datadog" {
  source = "../module/datadog"

  standard_users = [
    { name = "Norihiko Sakata", email = "norihiko.sakata@happyelements.co.jp" },
  ]
  readonly_users = [
  ]

  monitors = [
    {
      name                = "Notice of AWS usage fee"
      query               = "avg(last_4h):avg:aws.billing.actual_spend{*} >= 1000"
      type                = "metric alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/aws/billing.actual_spend")
      thresholds          = { "critical" = "1000.0", "critical_recovery" = "500.0" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "Detect log output of dockerd service"
      query               = "logs(\"source:ec2 service:messages \\\"dockerd:\\\"\").index(\"main\").rollup(\"count\").last(\"15m\") >= 1"
      type                = "log alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/logs/ec2_messages_dockerd")
      thresholds          = { "critical" = "1.0" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "Detect log output of amazon-ecs-init service"
      query               = "logs(\"source:ec2 service:messages \\\"amazon-ecs-init:\\\"\").index(\"main\").rollup(\"count\").last(\"15m\") >= 1"
      type                = "log alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/logs/ec2_messages_amazon-ecs-init")
      thresholds          = { "critical" = "1.0" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "Detect log output of aurora slowquery"
      query               = "logs(\"source:rds @aws.awslogs.logGroup:\\/aws\\/rds\\/cluster\\/*\\/slowquery\").index(\"main\").rollup(\"count\").last(\"15m\") >= 1"
      type                ="log alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/logs/aurora_slowquery")
      thresholds          = { "critical" = "1.0" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "Detect log output of aurora error"
      query               = "logs(\"source:rds @aws.awslogs.logGroup:\\/aws\\/rds\\/cluster\\/*\\/error\").index(\"main\").rollup(\"count\").last(\"15m\") >= 1"
      type                = "log alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/logs/aurora_error")
      thresholds          = { "critical" = "1.0" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "Detect log output of kernel error"
      query               = "logs(\"source:ec2 service:kern\").index(\"main\").rollup(\"count\").last(\"15m\") >= 1"
      type                = "log alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/logs/ec2_kern")
      thresholds          = { "critical" = "1.0"}
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "A login action was detected."
      query               = "logs(\"source:ec2 service:secure\").index(\"main\").rollup(\"count\").last(\"5m\") >= 1"
      type                = "log alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/logs/ec2_secure")
      thresholds          = { "critical" = "1.0" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "The desired number has decreased in the task service."
      query               = "sum(last_15m):sum:aws.ecs.service.desired{service:xreq_test_web} - sum:aws.ecs.service.running{service:xreq_test_web} >= 3"
      type                = "query alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/aws/ecs.service.desired")
      thresholds          = { "critical" = "3.0", "critical_recovery" = "0.1" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "Response delay was detected by external shape monitoring."
      query               = "min(last_5m):avg:aws.route53.time_to_first_byte{*} by {name} > 500"
      type                = "metric alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/aws/route53.time_to_first_byte")
      thresholds          = { "critical" = "500.0", "critical_recovery" = "250.0" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "CPU IO_WAIT has exceeded the threshold."
      query               = "avg(last_15m):avg:system.cpu.iowait{*} by {host,name} > 30"
      type                = "query alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/system/cpu.iowait")
      thresholds          = { "critical" = "30.0", "critical_recovery" = "5.0" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "A status code error was detected by external shape monitoring."
      query               = "min(last_5m):avg:aws.route53.health_check_status{*} <= 0"
      type                = "query alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/aws/route53.health_check_status")
      thresholds          = { "critical" = "0.0", "critical_recovery" = "1.0" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "The disk usage threshold has been exceeded."
      query               = "max(last_15m):max:system.disk.in_use{*} by {host,name} > 0.6"
      type                = "query alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/system/disk.in_use")
      thresholds          = { "critical" = "0.6", "critical_recovery" = "0.5" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "ElastiCache was detected by events."
      query               = "events('priority:all sources:elasticache').rollup('count').last('5m') >= 1"
      type                = "query alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/events/elasticache")
      thresholds          = { "critical" = "1" }
      type                = "event alert"
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "The EBS burst balance threshold was detected."
      query               = "avg(last_10m):avg:aws.ebs.burst_balance{*} by {volumeid} < 85"
      type                = "query alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/aws/ebs.burst_balance")
      thresholds          = { "critical" = "85.0", "critical_recovery" = "99.0" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "AWS status (all regions)"
      query               = "events('priority:all sources:aws').rollup('count').last('5m') >= 1"
      type                = "event alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/events/aws")
      thresholds          = { "critical" = "1" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "Disk usage has exceeded the threshold."
      query               = "max(last_15m):max:system.disk.in_use{*} by {host,name} > 0.6"
      type                = "query alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/system/disk.in_use")
      thresholds          = { "critical" = "0.6", "critical_recovery" = "0.5" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "CPU usage has exceeded the threshold."
      query               = "max(last_15m):max:aws.ec2.cpuutilization{*} by {host,name} > 80"
      type                = "query alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/aws/ec2.cpuutilization")
      thresholds          = { "critical" = "80.0", "critical_recovery" = "50.0" }
      renotify_interval   = 0
      timeout_h           = 0
    },
    {
      name                = "AutoScalingGroup was detected by events."
      query               = "events('priority:all sources:autoscaling').rollup('count').last('5m') >= 1"
      type                = "event alert"
      evaluation_delay    = 0
      message             = file("${path.module}/message/events/autoscaling")
      thresholds          = { "critical" = "1" }
      renotify_interval   = 0
      timeout_h           = 0
    },

  ]
}
```
