variable "bucket_name" {
  description = "The name of the bucket."
  type        = string
  default     = null
}

variable "acl" {
  description = "The canned ACL to apply. Defaults to 'private'. Conflicts with `grant`"
  type        = string
  default     = "private"
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "versioning" {
  description = "Enable versioning."
  type        = bool
  default     = true
}

variable "mfa_delete" {
  description = "Enable MFA delete for either Change the versioning state of your bucket or Permanently delete an object version"
  type        = bool
  default     = false
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}
