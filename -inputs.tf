variable "name" {
  description = "String to use for s3 bucket name"
  type        = string
}

variable "input_tags" {
  description = "Map of tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "transition_IA" {
  description = "Number of days before transitioning data to S3 Infrequently Accessed"
  type        = string
  default     = "180"
}

variable "transition_glacier" {
  description = "Number of days before transitioning data to Glacier"
  type        = string
  default     = "366"
}

variable "transition_expiration" {
  description = "Number of days before expiring data completely"
  type        = string
  default     = "2557"
}
