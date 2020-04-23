# terraform-aws-s3-bucket-logging
This module configures a bucket with:
 - Server Side Encryption (Not KMS)
 - Requires encrypted transit
 
 ## Example Usage:
```
module "s3_bucket_logging" {
  source  = "StratusGrid/s3-bucket-logging/aws"
  version = "1.1.0"
  name_prefix = "${var.name_prefix}-logging"
  input_tags = local.common_tags
}
```
