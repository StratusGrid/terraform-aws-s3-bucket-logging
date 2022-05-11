module "s3_bucket_logging" {
  source  = "StratusGrid/s3-bucket-logging/aws"
  version = "2.0.1"
  name_prefix = "${var.name_prefix}"
  input_tags = local.common_tags
  versioning_enabled = true #Enabled by default
}