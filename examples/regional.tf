module "s3_bucket_logging_us_east_2" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "2.0.1"
  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-east-2"
  input_tags  = merge(local.common_tags, {})
  providers = {
    aws = aws.us-east-2
  }
  versioning_enabled = true #Enabled by default
}