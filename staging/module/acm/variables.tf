variable "domain_name" {
  description = "The Hosted Zone name of the desired Hosted Zone."
  type        = string
  default     = ""
}

variable "fqdn" {
  description = "A domain name for which the certificate should be issued"
  type        = string
  default     = ""
}

variable "subject_alternative_names" {
  description = "A list of domains that should be SANs in the issued certificate"
  type        = list(string)
  default     = []
}

variable "validation_method" {
  description = "Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
  type        = string
  default     = "DNS"
}

variable "ttl" {
  description = "The TTL of DNS recursive resolvers to cache information about this record."
  type        = number
  default     = 60
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
