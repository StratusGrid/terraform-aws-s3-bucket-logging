# terraform-aws-s3-bucket-logging
This module configures a bucket with:
 - Server Side Encryption (Not KMS)
 - Requires encrypted transit
 - A randomly generated UID after the name
 
 ## Example Usage:
```
module "s3_logging" {
  source = "github.com/StratusGrid/terraform-aws-s3-bucket-logging"
  name_prefix = "${var.name_prefix}"
  logging_bucket_id = "${module.s3_bucket_logging.bucket_id}"
  input_tags = "${local.common_tags}"
}
```
