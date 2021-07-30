# Local Values
locals {
  archive_file_type      = "zip"
  deploy_upload_filename = "lambda_src.zip"
}

# Lambda Function
resource "aws_lambda_function" "lambda" {
  filename         = data.archive_file.lambda_file.output_path
  function_name    = var.name
  role             = var.role_arn
  handler          = var.lambda_handler
  runtime          = var.function_runtime
  layers           = var.layers
  source_code_hash = data.archive_file.lambda_file.output_base64sha256
  memory_size      = var.memory_size
  timeout          = var.timeout
  publish          = var.publish
  
  dynamic "environment" {
    for_each = var.environments == "" ? [] : var.environments
    #for_each = var.environments
    content {
      variables = environment.value.variables
    }
  }

  tags = var.tags
}

# CloudWatch Logs
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${var.name}"
  retention_in_days = var.log_retention_in_days

  tags = var.tags
}

# Lambda File Zip
data "archive_file" "lambda_file" {
  type        = local.archive_file_type
  source_dir  = var.lambda_source_dir
  output_path = local.deploy_upload_filename
}

