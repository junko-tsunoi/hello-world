variable "name" {}
variable "lambda_source_dir" {}
variable "role_arn" {}
variable "lambda_handler" {}
variable "function_runtime" {}
variable "layers" {}
variable "memory_size" {}
variable "timeout" {}
variable "log_retention_in_days" {}
#variable "environments" { default = [{ variables = {} }] }
variable "environments" { default = [] }
variable "tags" {}
variable "publish" { default = false }
