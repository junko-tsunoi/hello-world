variable "vpc" {
  type        = bool
  description = "VPCのデータを読み取りたい場合はtrue"
  default     = false
}

variable "aurora" {
  type        = bool
  description = "Auroraのデータを読み取りたい場合はtrue"
  default     = false
}

variable "acm" {
  type        = bool
  description = "ACMのデータを読み取りたい場合はtrue"
  default     = false
}

variable "s3" {
  type        = bool
  description = "S3のデータを読み取りたい場合はtrue"
  default     = false
}

variable "ec2" {
  type        = bool
  description = "EC2（main）のデータを読み取りたい場合はtrue"
  default     = false
}

variable "batch" {
  type        = bool
  description = "EC2(batch)のデータを読み取りたい場合はtrue"
  default     = false
}

variable "cloudfront" {
  type        = bool
  description = "CloudFrontのデータを読み取りたい場合はtrue"
  default     = false
}

variable "codedeploy" {
  type        = bool
  description = "CodeDeployのデータを読み取りたい場合はtrue"
  default     = false
}
