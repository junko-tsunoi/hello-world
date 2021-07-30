variable "bucket_name" {
  description = "The name of the bucket."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable versioning."
  type        = bool
  default     = true
}

variable "standard_ia_day" {
  description = "Specifies the number of days after object creation when STANDARD_IA takes effect."
  type = number
  default = 30
}

variable "glacier_day" {
  description = "Specifies the number of days after object creation when GLACIER takes effect."
  type = number
  default = 60
}

variable "expiration_day" {
  description = "Specifies the number of days after object creation when the specific rule action takes effect."
  type = number
  default = 180
}

variable "region" {
    description = "Region to create s3 bucket."
    type = string
    default = "ap-northeast-1"
}

variable "region_alb" {
  type = map(any)
  default = {
    us-east-1      = "127311923021"
    us-east-2      = "033677994240"
    us-west-1      = "027434742980"
    us-west-2      = "797873946194"
    ca-central-1   = "985666609251"
    eu-central-1   = "054676820928"
    eu-west-1      = "156460612806"
    eu-west-2      = "652711504416"
    eu-west-3      = "009996457667"
    eu-north-1     = "897822967062"
    ap-northeast-1 = "582318560864"
    ap-northeast-2 = "600734575887"
    ap-northeast-3 = "383597477331"
    ap-southeast-1 = "114774131450"
    ap-southeast-2 = "783225319266"
    ap-south-1     = "718504428378"
    sa-east-1      = "507241528517"
  }
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}

