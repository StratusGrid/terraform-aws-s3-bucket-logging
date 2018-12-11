# terraform-aws-s3-bucket-logging
This module configures a bucket with:
 - Server Side Encryption (Not KMS)
 - Requires encrypted transit
 - A randomly generated UID after the name
 
 ## Example Usage:
```
module "s3_bucket_logging" {
  source  = "StratusGrid/s3-bucket-logging/aws"
  version = "1.0.0"
  name_prefix = "${var.name_prefix}"
  input_tags = "${local.common_tags}"
}
```
