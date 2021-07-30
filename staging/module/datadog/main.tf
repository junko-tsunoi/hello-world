## module/datadog/main.tf

resource "datadog_user" "standard" {
  count = length(var.standard_users)

  access_role = "st"
  disabled    = false

  name   = lookup(var.standard_users[count.index], "name")
  email  = lookup(var.standard_users[count.index], "email")
  handle = lookup(var.standard_users[count.index], "email")
}

resource "datadog_user" "readonly" {
  count = length(var.readonly_users)

  access_role = "ro"
  disabled    = false

  name   = lookup(var.readonly_users[count.index], "name")
  email  = lookup(var.readonly_users[count.index], "email")
  handle = lookup(var.readonly_users[count.index], "email")
}


resource "datadog_monitor" "default" {
  count = length(var.monitors)

  name                = lookup(var.monitors[count.index], "name")
  query               = lookup(var.monitors[count.index], "query")
  type                = lookup(var.monitors[count.index], "type")
  evaluation_delay    = lookup(var.monitors[count.index], "evaluation_delay")
  message             = lookup(var.monitors[count.index], "message")
  thresholds          = lookup(var.monitors[count.index], "thresholds")
  renotify_interval   = lookup(var.monitors[count.index], "renotify_interval")
  timeout_h           = lookup(var.monitors[count.index], "timeout_h")
}

