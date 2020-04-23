# terraform-aws-s3-bucket-logging
This module configures a bucket with:
 - Server Side Encryption (Not KMS)
 - Requires encrypted transit
 
## Example Usage
### Simple:
```
module "s3_bucket_logging" {
  source  = "StratusGrid/s3-bucket-logging/aws"
  version = "1.2.1"
  name_prefix = "${var.name_prefix}"
  input_tags = local.common_tags
}
```
### Regional:
```
module "s3_bucket_logging_us_east_2" {
  source      = "StratusGrid/s3-bucket-logging/aws"
  version     = "1.2.1"
  name_prefix = var.name_prefix
  name_suffix = "${local.name_suffix}-us-east-2"
  input_tags  = merge(local.common_tags, {})
  providers = {
    aws = aws.us-east-2
  }
}
```